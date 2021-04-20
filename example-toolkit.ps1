<#
.SYNOPSIS
Supporting the different modules via powershell and merge as toolkit.

.DESCRIPTION
Capable of allowing to assemble a collection various admin tasks.

.NOTES
Name: ps-toolkit
Creator: itsAbyzou
#>

Function Init {

    # load variables before building the menu

    $global:Title = "ps-toolkit"
    $global:DescriptionName = "Toolkit by itsAbyzou"
	$global:Domain = "EXAMPLEDOMAIN\"


    # load the design

    Clear-Host
    $console = $host.ui.RawUI
    $console.WindowTitle = $global:Title + " - " + $global:DescriptionName
    $console.BackgroundColor = ($bckgrnd = 'Black')
    $console.ForegroundColor = "white"
    $size = $console.WindowSize
    $size.width = 85
    $size.height = 60
    $console.windowSize = $size
    $size = $console.Buffersize
    $size.width = 85
    $size.height = 5000
    $console.Buffersize = $size

    # load windows forms assembly

    [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | out-Null

    # background for first userinput

    Clear-Host
    Write-Host "`n`n`t`t          Example Toolbox"         -Fore gray
    Write-Host "`t`t              By itsAbyzou"            -Fore gray

	<#	example script for loading a domain connection before
	
    # try to load an AD module, if connecting to domain

    Try {
        Import-Module ActiveDirectory -ErrorAction Stop
    }
    Catch {
        Write-Host "`n[ERROR]`t ActiveDirectory Module couldn't be loaded. Script will be stopped now!" -Fore red
        Exit 1
    }

    # check connection to domain

    Try {
        $global:addn = (Get-ADDomain).DistinguishedName
        $global:dnsroot = (Get-ADDomain).DNSRoot
        $global:date = Get-Date
    }
    Catch {
        Write-Host "[ERROR]`t Could not load a specific variable. Script will be stopped now!" -Fore red
        Exit 1
    }
	#>

}



Function Menu {

    # define menu variables

    $MenuSelection = $null
    $AppName = "ps-toolkit by itsAbyzou"
    [INT]$Menu1 = 0
    [INT]$Menu2 = 0
    [BOOLEAN]$xValidSelection = $false
    [BOOLEAN]$global:xExitSession = $false

    # main menu

    while ( $true) {
        Clear-Host
        Write-Host "`n`n`t Welcome to the example toolkit. Your" -Fore darkgreen
        Write-Host "`t one stop shop for all administrative needs.`n" -Fore darkgreen

        # menu options

        Write-Host "`n`tSelect from the menu:`n" -Fore gray
        Write-Host "`t 1. Submenu 1" -Fore gray
        Write-Host "`t 2. Submenu 2" -Fore gray
        Write-Host
        Write-Host "`t99. Quit and exit`n" -Fore gray

        if ($Menu1 = MenuInputValidation 6) {
            break;
        }

    }

	#define the scripts you want to use in the menu below
	
    Switch ($Menu1) {
        # load second menu part 1
        1 {
            $Menu2 = MenuEntries @("Script 1", "Script 2")

            Switch ($Menu2) {
                1 { HelloWorld; break; }
                2 { HelloWorld2s; break; }
            }

        # load second menu part 2
        } 2 {
            $Menu2 = MenuEntries @("-", "-", "-")

            Switch ($Menu2) {
                1 { Write-Host "`n`t111111111111111111111111111`n" -Fore Yellow; start-Sleep -Seconds 3 }
            }

		# exit break point
        } 99 {
            $global:xExitSession = $true; break
        }
    }
}

Function MenuLoop {
	
	# create the function to loop inside of the menu

    If ($global:xExitSession) {
        exit-pssession
    }
    else {
        Menu
        MenuLoop
    }
}

Function MenuEntries($menuEntries) {
	
	# create the function to input inside of menus
	
    while ( $true ) {
        Clear-Host
        Write-Host "`n`n`t Welcome to the example toolkit. Your" -Fore darkgreen
        Write-Host "`t one stop shop for all administrative needs.`n" -Fore darkgreen
        Write-Host "   Select from the menu`n" -Fore gray

        $menuEntries | ForEach-Object {
            $num = ($menuEntries.IndexOf($_) + 1)
            Write-Host "    ${num}. " $_ -Fore gray
        }

        Write-Host
        Write-Host "   99. Go to Main Menu`n" -Fore gray

        if ($inputValue = MenuInputValidation $menuEntries.Count) {
            return $inputValue
        }
    }
}

Function MenuInputValidation([int]$maxMenuNumber) {
	
	# create the validation to check for non-numeric values

    try {
        [int]$inputValue = Read-Host "`n`n Enter option number [1-${maxMenuNumber}]"
    }
    catch {
        Write-Host "`tPlease enter only numeric values." -Fore Red; start-Sleep -Seconds 1
        return 0
    }

    if ( $inputValue -lt 1 -or $inputValue -gt $maxMenuNumber -and $inputValue -ne 99 ) {
        Write-Host "`tPlease select one of the options available." -Fore Red; start-Sleep -Seconds 1
        return 0
    }

    return $inputValue
}





# ------------------------------------------------------------- Functions -------------------------------------------------------------

Function HelloWorld {

        Write-Host 'Hello, World!'

}

Function HelloWorld2 {

        Write-Host 'Hello, World! Number 2!'

}

# ------------------------------------------------------------- Loading Order and Exit or Reload -------------------------------------------------------------

Init
Menu
MenuLoop
