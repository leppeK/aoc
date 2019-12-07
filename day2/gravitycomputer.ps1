$programTemplate=(Get-Content $PSScriptRoot\input).Split(",")
function runGravityComputer {
    param (
        [array]$progam
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

runGravityComputer -progam $programTemplate

# while ($result -ne $expectedResult) {
    
#     break
# }