$scriptblock = {
    param(
        $wordToComplete, 
        [System.Management.Automation.Language.Ast] $commandAst, 
        $cursorPosition
    )
    $words = $commandAst.ToString().Split(' ')
    write-verbose "words: $words wordToComplete: '$wordToComplete' cursor: $cursorPosition" 
    $cmd = $($words[0])
    $rest = $words[1..($words.Length - 1)]
    if ($words.Length -eq 1) {
        $rest = @()
    }
    if ([string]::IsNullOrWhiteSpace($wordToComplete)) {
        Write-Verbose "null word to complete"
        $rest += @('')
    }

    $letterAtCursor = $wordToComplete[$cursorPosition - 1]
        
    $requestComp = "$cmd __complete $rest"        
    write-verbose "command: '$requestComp'"

    $result = & $($words[0]) __complete @rest

    write-verbose "result: $result" 
    $done = $false
    $result | % {
        if ($_.startsWith(":")) {
            $done = $true
        }
        if (!$done) {   
            $splits = $_.Split("`t")
            $item = $splits[0]
            $desc = $splits[1]
            if ($desc -eq $null) {
                $desc = $item
            }
            write-verbose "item: $item desc: $desc" 

            [System.Management.Automation.CompletionResult]::new($item, $item, 'ParameterValue', $desc)    
        }
    }
}

Register-ArgumentCompleter -Native -CommandName bns -ScriptBlock $scriptblock