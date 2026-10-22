param([string]$bin, [string]$out)
$B = "C:\Users\RDP\Documents\Default Project\Eris Dysnomia\Data\BasicData"
$lines = @()
foreach ($id in 0..583) {
  $run = & $bin commonrun "$B\CommonEvent.dat" $id --cap 100000 --db "$B\DataBase.project" "$B\DataBase.dat" --cdb "$B\CDataBase.project" "$B\CDataBase.dat" 2>&1 | Out-String
  $code = $LASTEXITCODE
  $v = if ($code -eq 0) { "OK" }
       elseif ($run -match "step cap exceeded") { "STEPCAP" }
       elseif ($run -match "recursion cap") { "RECCAP" }
       else {
         $m = [regex]::Match($run, "RUN FAILED: (.*)").Groups[1].Value
         if ($m.Length -gt 80) { $m = $m.Substring(0, 80) }
         "OTHER: $m"
       }
  $lines += "{0,-6} {1}" -f $id, $v
}
$lines | Set-Content -Encoding utf8 $out
"DONE $out"
