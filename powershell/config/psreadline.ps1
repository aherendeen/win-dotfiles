# PSReadLine Configuration
# Syntax highlighting, history, and prediction settings

# Prediction and history
Set-PSReadLineOption -PredictionSource HistoryAndPlugin -ErrorAction SilentlyContinue
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineOption -MaximumHistoryCount 10000
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -HistoryNoDuplicates

# Dracula color scheme
# https://draculatheme.com/
Set-PSReadLineOption -Colors @{
    Command            = "#f8f8f2"  # Foreground
    Parameter          = "#ffb86c"  # Orange
    Operator           = "#ff79c6"  # Pink
    Variable           = "#8be9fd"  # Cyan
    String             = "#f1fa8c"  # Yellow
    Number             = "#bd93f9"  # Purple
    Member             = "#50fa7b"  # Green
    InlinePrediction   = "#6272a4"  # Comment
    ListPrediction     = "#8be9fd"  # Cyan
    ContinuationPrompt = "#6272a4"  # Comment
    Emphasis           = "#ff5555"  # Red
    Error              = "#ff5555"  # Red
    Selection          = "#44475a"  # Selection
    Comment            = "#6272a4"  # Comment
    Keyword            = "#ff79c6"  # Pink
    Type               = "#8be9fd"  # Cyan
}
