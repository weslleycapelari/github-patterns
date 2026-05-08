# Architecture Patterns

## Objective

Ensure that AI and developers implement architecture with explicit separation of concerns, inverted dependencies, and predictable data flow across layers.

This standard defines:

- how a request enters, is processed, and returns to the client;
- where each type of logic must exist;
- how to apply SOLID operationally, not ornamentally;
- how to standardize dependency injection and response envelopes in APIs.

## Non-Negotiable Principles

1. Controller contains no business logic.
2. Service has no knowledge of HTTP protocol details.
3. Repository contains no business orchestration.
4. DTO exists to transport data with an explicit contract across boundaries.
5. Dependencies must point to abstractions, never to concrete details when an architectural boundary exists.
6. Every public API response must conform to a single, predictable envelope.

## Separation Of Concerns

Architecture is only clear when each layer has a single responsibility and a distinct reason to change.

### Controller

Responsible for:

- receiving the request;
- validating format, authentication, authorization, and boundary parameters;
- converting input to an input DTO;
- delegating execution to the Service;
- translating the result into the standardized HTTP envelope.

Must never:

- access the database directly;
- build SQL;
- apply complex business logic;
- contain domain branching that belongs to the Service.

### Service

Responsible for:

- executing business logic;
- orchestrating multiple repositories or gateways;
- applying domain invariants;
- deciding success, failure, conflict, idempotency, and consistency;
- returning output DTOs or domain errors.

Must never:

- depend on request, response, headers, or status code;
- serialize JSON;
- know the web framework;
- instantiate concrete dependencies internally.

### Repository

Responsible for:

- encapsulating persistence;
- executing reads and writes to a database, cache, or storage;
- mapping persisted data to domain entities or structures;
- hiding ORM, query builder, or driver details.

Must never:

- receive HTTP objects;
- contain authorization logic;
- build response envelopes;
- decide business behavior beyond persistence constraints.

### DTO

Responsible for:

- formalizing the input and output contract across boundaries;
- preventing internal entity leakage;
- stabilizing the public API format;
- making validation, serialization, and documentation predictable.

Must never:

- contain rich business behavior;
- carry infrastructure dependencies;
- expose internal fields that are not part of the external contract.

## Flow Of Data

A healthy request must traverse the layers in this order and without shortcuts:

```text
Client
  -> Controller
  -> Input DTO
  -> Service
  -> Repository
  -> Service
  -> Output DTO
  -> Response Envelope
  -> Client
```

### Operational Flow

1. The client sends the HTTP request.
2. The Controller authenticates, authorizes, validates structural fields, and creates the input DTO.
3. The Controller calls the Service through an interface or stable contract.
4. The Service executes the business logic and orchestrates dependencies.
5. If persistence is needed, the Service calls the Repository.
6. The Repository accesses the data source and returns a domain structure or persisted record.
7. The Service transforms the result into an output DTO.
8. The Controller applies the single response envelope.
9. The client receives a consistent response, regardless of the use case.

### Good Flow Example

```ts
type CreateUserRequestDto = {
  email: string;
  displayName: string;
};

type UserResponseDto = {
  id: string;
  email: string;
  displayName: string;
};

interface UserRepository {
  findByEmail(email: string): Promise<UserRecord | null>;
  create(input: CreateUserRecord): Promise<UserRecord>;
}

class CreateUserService {
  constructor(private readonly userRepository: UserRepository) {}

  async execute(input: CreateUserRequestDto): Promise<UserResponseDto> {
    const existingUser = await this.userRepository.findByEmail(input.email);

    if (existingUser) {
      throw new ConflictError('User already exists');
    }

    const createdUser = await this.userRepository.create({
      email: input.email,
      displayName: input.displayName,
    });

    return {
      id: createdUser.id,
      email: createdUser.email,
      displayName: createdUser.displayName,
    };
  }
}

class UserController {
  constructor(private readonly createUserService: CreateUserService) {}

  async create(request: HttpRequest): Promise<HttpResponse> {
    const input: CreateUserRequestDto = {
      email: request.body.email,
      displayName: request.body.displayName,
    };

    const user = await this.createUserService.execute(input);

    return ok(user, request.id);
  }
}
```

### Bad Flow Example

```ts
class UserController {
  async create(request: HttpRequest): Promise<HttpResponse> {
    const existingUser = await database.users.findByEmail(request.body.email);

    if (existingUser) {
      return {
        status: 409,
        body: { message: 'User already exists' },
      };
    }

    const createdUser = await database.users.insert({
      email: request.body.email,
      displayName: request.body.displayName,
    });

    audit.log('USER_CREATED', createdUser.id);

    return {
      status: 201,
      body: createdUser,
    };
  }
}
```

This flow is incorrect because it mixes HTTP protocol, data access, business logic, auditing, and output contract in a single layer.

## SOLID Applied In Practice

SOLID is only valid here when it changes concrete design decisions.

### S: Single Responsibility Principle

Mandatory application:

- Controller changes when the HTTP interface changes.
- Service changes when the business logic changes.
- Repository changes when the persistence strategy changes.
- DTO changes when the transport contract changes.

Violation signal:

- the same class changes for transport, business, and persistence reasons at the same time.

### O: Open Closed Principle

Mandatory application:

- new providers, gateways, and repositories must enter through new implementations, not through cascading edits to consumers;
- new use cases must compose existing contracts when possible.

Violation signal:

- every new data source requires editing the Service;
- every new response variant requires manually altering multiple controllers.

### L: Liskov Substitution Principle

Mandatory application:

- any interface implementation must preserve the expected return, error, and semantic contract;
- a substitutable repository must maintain the same observable behavior for the Service.

Violation signal:

- one implementation returns null when another throws an error for the same contract;
- one implementation changes the result format or pagination semantics without adjusting the abstraction.

### I: Interface Segregation Principle

Mandatory application:

- each consumer depends only on the minimum contract it needs;
- repository interfaces must be focused by aggregate or use case.

Violation signal:

- a Service depends on a mega repository with dozens of irrelevant methods;
- test mocks require implementing methods the use case never calls.

### D: Dependency Inversion Principle

Mandatory application:

- Services depend on repository, gateway, and broker interfaces;
- concrete wiring occurs in the application composition, never inside business logic.

Violation signal:

- use of new inside the Service to create a repository, HTTP client, or external provider;
- direct coupling of business logic to a specific ORM, SDK, or framework.

## Dependency Injection

Dependency Injection is the operational way to fulfill DIP and make the architecture testable.

### Always

- Always inject dependencies through the constructor or an equivalent composition root.
- Always depend on interfaces when an architectural boundary exists.
- Always concentrate wiring in a bootstrap, container, or composition factory.
- Always replace infrastructure with doubles in Service tests.

### Never

- Never instantiate a repository, HTTP client, structural logger, or external provider inside the Service.
- Never couple the Controller to concrete database implementations.
- Never use injection to hide too many dependencies; explicit dependency remains a requirement.

### Bad vs Good

```ts
// Bad
class ResetPasswordService {
  async execute(email: string): Promise<void> {
    const repository = new PostgresUserRepository();
    const mailer = new SmtpMailer();

    const user = await repository.findByEmail(email);
    if (!user) throw new NotFoundError('User not found');

    await mailer.sendResetLink(user.email);
  }
}

// Good
interface UserRepository {
  findByEmail(email: string): Promise<UserRecord | null>;
}

interface MailerGateway {
  sendResetLink(email: string): Promise<void>;
}

class ResetPasswordService {
  constructor(
    private readonly userRepository: UserRepository,
    private readonly mailerGateway: MailerGateway,
  ) {}

  async execute(email: string): Promise<void> {
    const user = await this.userRepository.findByEmail(email);
    if (!user) throw new NotFoundError('User not found');

    await this.mailerGateway.sendResetLink(user.email);
  }
}
```

## Standard Response Envelope

Every public API must respond with a uniform envelope for both success and error. The client must not infer structure from the route.

### Response Contract

```json
{
  "success": true,
  "data": {},
  "errors": [],
  "meta": {
    "requestId": "f4e2f0f7-8d6d-4f79-a8dc-0d5989a4b801",
    "timestamp": "2026-05-07T12:00:00.000Z"
  }
}
```

### Envelope Rules

- success indicates the operational result of the request.
- data contains only public DTOs or paginated collections of them.
- errors contains structured objects when there is a failure.
- meta contains minimum technical context, such as requestId and timestamp.

### Error Contract

```json
{
  "success": false,
  "data": null,
  "errors": [
    {
      "code": "USER_ALREADY_EXISTS",
      "message": "User already exists",
      "field": "email"
    }
  ],
  "meta": {
    "requestId": "f4e2f0f7-8d6d-4f79-a8dc-0d5989a4b801",
    "timestamp": "2026-05-07T12:00:00.000Z"
  }
}
```

### Always: Response Envelope

- Always return a consistent envelope on both success and error.
- Always map domain errors to stable, readable codes.
- Always return DTOs in data, never internal entities or raw ORM records.
- Always include requestId for operational traceability.

### Never: Response Envelope

- Never return different formats for local endpoint convenience.
- Never expose stack traces, internal database messages, or sensitive details.
- Never mix raw technical errors with public business messages.
- Never return a raw database object directly to the client.

## Data Travel Guide

Use this mental model for any endpoint:

1. Input enters through the HTTP boundary.
2. Controller validates the shape.
3. DTO stabilizes the contract.
4. Service decides the behavior.
5. Repository executes persistence.
6. Service consolidates the result.
7. Output DTO protects the external contract.
8. Envelope padroniza a resposta final.

Se qualquer camada pular para outra responsabilidade, a arquitetura já começou a degradar.

## Review Checklist

Antes de aprovar qualquer fluxo arquitetural, validar:

1. O Controller só faz trabalho de borda e delegação?
2. A Service está livre de detalhes HTTP e framework?
3. O Repository está isolando persistência sem regra de negócio indevida?
4. DTOs estão protegendo o contrato externo?
5. As dependências estão invertidas para abstrações relevantes?
6. O envelope de resposta está consistente entre sucesso e erro?
7. SOLID está reduzindo acoplamento real ou só adicionando camadas vazias?

## Enforcement

Se uma classe toca HTTP, regra de negócio e persistência ao mesmo tempo, ela está errada.

Se uma Service cria sua própria infraestrutura, DIP foi quebrado.

Se a API responde com formatos diferentes para cada endpoint, o contrato público está degradado.

Se SOLID não melhora testabilidade, extensibilidade ou clareza, ele está sendo aplicado como ritual e deve ser simplificado.
