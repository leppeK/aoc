$programTemplate=(Get-Content $PSScriptRoot\input).Split(",")
function runGravityComputer {
    param (
        [array]$program
    )
    $pos = 0
    [int]$opcode = $program[$pos]
    while($opcode -ne 99){
    # $opcode
        switch($opcode){
            1{
                #add #pos+1 to pos+2 and store at location of pos+3
                [int]$program[[int]$program[($pos+3)]] = (([int]$program[[int]$program[($pos+1)]]) + ([int]$program[[int]$program[($pos+2)]])) 

            }
            2{
                [int]$program[[int]$program[($pos+3)]] = (([int]$program[[int]$program[($pos+1)]]) * ([int]$program[[int]$program[($pos+2)]]))
            }
            default{Write-Host "Error pos = $pos opcode = $opcode"}
        }
        $pos+=4
        $opcode = $program[$pos]
    }
    return $program
}
$expectedResult = 19690720

for ($x = 0; $x -lt 99; $x++) {
    for ($y = 0; $y -lt 99; $y++) {
        $a = $programTemplate.Clone()
        $a[1]=$x
        $a[2]=$y
        if ((runGravityComputer -program $a)[0] -eq $expectedResult){
            100*$x+$y
        }
    }
}