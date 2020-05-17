Clear-Host

Write-Host -ForegroundColor YELLOW “`n======Let's Get Started======”



# Validates the Input for Integer and returns the value.
function Input-Validation( $value)
{
    $InputValue = 0
    DO{
    [int]$InputValid = [int]::TryParse((Read-Host 'Enter your choice '), [ref]$InputValue)
    if ((-not $InputValid) -or ( $InputValue -gt $value)) {
            Write-Host -ForegroundColor RED "`nYOUR CHOICE WAS INVALID!!`n"
            $InputValid = 0
            }
       }while(-not $InputValid)
    return $InputValue
}


# Display's Services which are Running, Stopped, Started, Paused.
function Services-Information
{
        Do
        {Write-Host -ForegroundColor GREEN “`nChoose an option`n`nDisplay services which are`n`n1.Started`n2.Stopped`n3.Running`n4.Paused`n5.Back`n”
        
        $ServiceChoice = Input-Validation(5)

        $StatusValue = ""

        if($ServiceChoice -eq 5){break}
        
        Switch($ServiceChoice)
        {
            1 {$StatusValue = "Started";break }
            2 {$StatusValue = "Stopped";break}
            3 {$StatusValue = "Running";break}
            4 {$StatusValue = "Paused";break}
        }

        $ServiceList = Get-Service | ?{$_.status -eq $StatusValue}
        if( -not $ServiceList)
        {
         Write-Host -ForegroundColor Red "`n No services are in $StatusValue state"
        }
        else
        {
         $ServiceList   
        }} while(1)
}

# File-Handling
function Files-Information
{
    Do{ Write-Host -ForegroundColor GREEN “`nChoose an option`n`n1.Create a new text file and add content to it`n2.Append content to exisitng file`n3.Display Content`n4.Remove the file`n5.Back`n”
        
        $FileChoice = Input-Validation(5)

        if($FileChoice -eq 5){break}

       Switch($FileChoice)
       {
            1 {
                $FileExists = ls | ?{$_.Name -eq "data.txt"}
                if($FileExists)
                {Write-Host -ForegroundColor DarkCyan "`n data.txt already exists, now it will be overridden `n";Remove-Item data.txt}
                $FileValue = Read-Host "`nEnter the data into file "
                New-Item data.txt;
                Set-Content data.txt $FileValue;
                Write-Host -ForegroundColor DarkCyan "`n Data is written into file : data.txt `n"
                break;

               }
            2 {
                $FileExists = ls | ?{$_.Name -eq "data.txt"}
                $FileValue = Read-Host "`nEnter the data into file "
                if($FileExists)
                {
                Add-Content data.txt $FileValue
                }
                else
                {
                New-Item data.txt
                Set-Content data.txt $FileValue
                }
                Write-Host -ForegroundColor DarkCyan "`n Data is written into file : data.txt `n"
                break;

                }
            3 {
                $FileExists = ls | ?{$_.Name -eq "data.txt"}
                if($FileExists)
                {
                    Write-Host -ForegroundColor Green "`n Data : `n"
                    Get-Content data.txt

                }
                else
                {
                    Write-Host -ForegroundColor Red "`n File doesn't exist `n"
                }
                break;
                }
            4 {
                $FileExists = ls | ?{$_.Name -eq "data.txt"}
                if($FileExists)
                {
                    Remove-Item data.txt
                    Write-Host -ForegroundColor DarkCyan "`n File is removed "

                }
                else
                {
                    Write-Host -ForegroundColor Red "`n File doesn't exist `n"
                }
                break;
                
            }
       }} while(1)

}

# Disk Storage Information
function DiskFreeSpace
{
    Get-PSDrive | ?{$_.Free -gt 1} | %{$Count = 0;"";} { $_.Name + ": Used: " + "{0:N2}" -f ($_.Used/1gb) + " || Free: " + "{0:N2}" -f ($_.free/1gb) + " || Total: " + "{0:N2}" -f (($_.Used/1gb)+($_.Free/1gb)); $Count = $Count + $_.Free;}{Write-Host"";Write-Host "Total Free Space " ("{0:N2}" -f ($Count/1gb)) -backgroundcolor DarkGray "`n"};
}

# Guessing - Game
function Guessing-Game
{
    Add-Type -AssemblyName PresentationCore,PresentationFramework
    Add-Type -AssemblyName Microsoft.VisualBasic
    $computer = Get-Random -Maximum 9 -Minimum 1
    $user = [Microsoft.VisualBasic.Interaction]::InputBox('Enter your number', "Guessing-Game")
    $NumberOfGuesses = 1
    while($user -ne $computer)
    {
     if($user -lt $computer){[System.Windows.MessageBox]::Show("Sorry mate! Too Low ","Guessing-Game","OK","Exclamation")}
     if($user -gt $computer){[System.Windows.MessageBox]::Show("Sorry mate! Too High ","Guessing-Game","OK","Exclamation")}
     if($NumberOfGuesses -ge 5){[System.Windows.MessageBox]::Show("Sorry mate! Your are out of attempts. ","Guessing-Game","OK","Exclamation");break;}
     $NumberOfGuesses += 1
     $user = [Microsoft.VisualBasic.Interaction]::InputBox('Enter your number', "Guessing-Game")
    }

    if($user -eq $computer)
    {[System.Windows.MessageBox]::Show("Congratulations!! You took $NumberOfGuesses guesses to win.","Guessing-Game","OK","Exclamation")}
    else
    {[System.Windows.MessageBox]::Show("Correct Number is $computer","Guessing-Game","OK","Exclamation")}

    [System.Windows.MessageBox]::Show("Game Ended!","Guessing-Game","OK","Exclamation")
}

# Checking Alias for given word
function Check-Alias_word
{
    Add-Type -AssemblyName PresentationCore,PresentationFramework
    Add-Type -AssemblyName Microsoft.VisualBasic
    $UserWord = [Microsoft.VisualBasic.Interaction]::InputBox('Enter your keyword', "Check Alias Word")
    $AliasWord = get-alias | ?{ $_.Name -eq $UserWord}
    if($AliasWord)
    {
     $info = Get-Alias $AliasWord
     $info = $info.displayname
     [System.Windows.MessageBox]::Show("$info","Check Alias Word","OK")
    }
    else
    {
     [System.Windows.MessageBox]::Show("No Alias Exist!!","Check Alias Word","OK","Exclamation")
    }
}


# Main Code
DO{
Write-Host -ForegroundColor GREEN “`nChoose an Option : `n`n1.Services`n2.File Opeartions`n3.Disk Free Space Information`n4.Guessing-Game`n5.Help with Alias Words`n6.Exit`n”

$UserChoice = Input-Validation(6)

Switch($UserChoice)
{
    1 {Services-Information;break}
    2 {Files-Information;break}
    3 {DiskFreeSpace;break;}
    4 {Guessing-Game;break;}
    5 {Check-Alias_word;break;}
}

}While($UserChoice -ne 6)