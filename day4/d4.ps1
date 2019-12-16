$inputrange=(206938..679128)
function ValidRange {
    param (
        $array
    )
    #array contains a duplicate of 2 
    if($array | Group-Object | Where-Object Count -eq 2){
        #when next number is lower than previous one the combination is invalid
        for ($i = 0; $i -lt ($array.Count -1 ); $i++) {
            if($array[($i+1)] -lt $array[($i)]){
                return $false
            }
        }
        return $true    
    }
    return $false
}
ValidRange (112233).ToString().ToCharArray()
ValidRange (123444).ToString().ToCharArray()
ValidRange (111122).ToString().ToCharArray()

$counter=0
foreach($combination in $inputrange){
    if(ValidRange $combination.ToString().ToCharArray()){
        $counter++
        $counter
    }
}
