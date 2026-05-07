param(
  [string]$Path = ".",
  [string]$OutputFile = "structure.md"
)

# =========================================
# Mapeamento de extensões -> linguagem markdown
# =========================================
$ExtensionMap = @{
  ".ps1"   = "powershell"
  ".js"    = "javascript"
  ".ts"    = "typescript"
  ".jsx"   = "jsx"
  ".tsx"   = "tsx"
  ".json"  = "json"
  ".html"  = "html"
  ".css"   = "css"
  ".scss"  = "scss"
  ".sass"  = "sass"
  ".php"   = "php"
  ".py"    = "python"
  ".java"  = "java"
  ".cs"    = "csharp"
  ".cpp"   = "cpp"
  ".c"     = "c"
  ".h"     = "c"
  ".go"    = "go"
  ".rs"    = "rust"
  ".rb"    = "ruby"
  ".kt"    = "kotlin"
  ".swift" = "swift"
  ".sql"   = "sql"
  ".xml"   = "xml"
  ".yml"   = "yaml"
  ".yaml"  = "yaml"
  ".md"    = "markdown"
  ".sh"    = "bash"
  ".bat"   = "bat"
  ".cmd"   = "bat"
  ".env"   = "env"
  ".txt"   = "text"
}

# =========================================
# Resolve caminho
# =========================================
$RootPath = (Resolve-Path $Path).Path

# =========================================
# Variáveis globais
# =========================================
$script:TreeOutput = ""
$script:MarkdownOutput = ""

# =========================================
# Monta árvore visual
# =========================================
function ConvertTo-Tree {
  param(
    [string]$CurrentPath,
    [string]$Prefix = ""
  )

  $items = Get-ChildItem -LiteralPath $CurrentPath |
  Sort-Object @{ Expression = { -not $_.PSIsContainer } }, Name

  for ($i = 0; $i -lt $items.Count; $i++) {
    $item = $items[$i]
    $isLast = ($i -eq $items.Count - 1)

    $connector = if ($isLast) { "└── " } else { "├── " }

    $script:TreeOutput += "$Prefix$connector$($item.Name)`n"

    if ($item.PSIsContainer) {
      $newPrefix = if ($isLast) {
        "$Prefix    "
      }
      else {
        "$Prefix│   "
      }

      ConvertTo-Tree -CurrentPath $item.FullName -Prefix $newPrefix
    }
  }
}

# =========================================
# Detecta linguagem markdown
# =========================================
function Get-MarkdownLanguage {
  param(
    [string]$Extension
  )

  $ext = $Extension.ToLower()

  if ($ExtensionMap.ContainsKey($ext)) {
    return $ExtensionMap[$ext]
  }

  return "text"
}

# =========================================
# Escapa bloco markdown
# =========================================
function Protect-MarkdownCode {
  param(
    [string]$Content
  )

  # Evita quebrar markdown caso tenha ```
  return $Content -replace '```', '````'
}

# =========================================
# Gera markdown dos arquivos
# =========================================
function Export-FilesToMarkdown {
  param(
    [string]$BasePath
  )

  $files = Get-ChildItem -LiteralPath $BasePath -Recurse -File

  foreach ($file in $files) {

    if ($file.FullName -ccontains $OutputFile) {
      continue
    }

    try {
      $relativePath = Resolve-Path -LiteralPath $file.FullName -Relative

      $language = Get-MarkdownLanguage $file.Extension

      $content = Get-Content -LiteralPath $file.FullName -Raw -ErrorAction Stop

      $content = Protect-MarkdownCode $content

      $script:MarkdownOutput += "`n"
      $script:MarkdownOutput += "---`n`n"
      $script:MarkdownOutput += "## $relativePath`n`n"
      $script:MarkdownOutput += "``````" + $language + "`n"
      $script:MarkdownOutput += $content
      $script:MarkdownOutput += "`n```````n`n"
    } 
    catch {
      $script:MarkdownOutput += "`n"
      $script:MarkdownOutput += "---`n`n"
      $script:MarkdownOutput += "## $relativePath`n`n"
      $script:MarkdownOutput += "_File reading error: $_ _`n`n"
    }
  }
}

# =========================================
# Gera árvore
# =========================================
$script:TreeOutput += "$RootPath`n"
ConvertTo-Tree -CurrentPath $RootPath

# =========================================
# Cabeçalho markdown
# =========================================
$script:MarkdownOutput += "# Project Structure`n`n"
$script:MarkdownOutput += "``````plaintext`n"
$script:MarkdownOutput += $script:TreeOutput
$script:MarkdownOutput += "```````n"

# =========================================
# Exporta conteúdo dos arquivos
# =========================================
Export-FilesToMarkdown -BasePath $RootPath

# =========================================
# Salva arquivo
# =========================================
$script:MarkdownOutput | Out-File -FilePath $OutputFile -Encoding UTF8

Write-Host ""
Write-Host "Markdown generated successfully:"
Write-Host $OutputFile
Write-Host ""