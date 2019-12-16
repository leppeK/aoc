$input=get-content -Path $PSScriptRoot\input
$wire1=$input[0]
$wire2=$input[1]

function TraceWirePath {
    param (
        $wireInstructions
    )
    $wirePath=New-Object System.Collections.Generic.List[System.Object]
    $wirePath.add((@(0,0)))
    $position = $wirePath[0].clone()
    foreach($instruction in $wireInstructions){
        $position = $wirePath[-1].clone()
        $position = CalculateWirePosition -wireInstruction $instruction -position $position
        $wirePath.add($position)
        
    }    
    return $wirePath
}
function CalculateWirePosition {
    param (
        $wireInstruction,
        $position
    )
    for ($i = 1; $i -ne $wireInstruction.Substring(1); $i++) {
        switch($wireInstruction.Substring(0,1)){
            "U"{
                $position += @($position[0], ($position[1]+$i))
            }
            "D"{
                $position += @($position[0], ($position[1]-$i))
            }
            "L"{
                $position += @(($position[0]-$i), $position[1])
            }
            "R"{
                $position += @(($position[0]+$i), $position[1])
            }
        }  
    }
    return $position
}
$wire1Path=TraceWirePath -wireInstructions $wire1.split(',')
$wire2Path=TraceWirePath -wireInstructions $wire2.split(',')

$bitmap = [System.Drawing.Bitmap]::new([int]20000,[int]20000)
# for ($x = 0; $x -lt $bitmap.Width; $x++) {
#     for ($y = 0; $y -lt $bitmap.Height; $y++) {
#         $bitmap.SetPixel($x,$y, [System.Drawing.Color]::White)
#     }
# }