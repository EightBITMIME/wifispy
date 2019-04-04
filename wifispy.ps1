function wifispy
{
         $number=0
         while($number -eq 0)
         {
                $number++
                Get-Process | netsh wlan show networks mode=bssid > file.txt         # save command output to text file
         }

         $lines = 0
         $SSID = Select-String -Path .\file.txt -pattern SSID 
         ForEach ($line in Get-Content "file.txt")        #reads each line of text file
         {

             if ($line -match "SSID" -and $line -notmatch "BSSID" )       #get SSIDs
             {
                  $line = $line.Split(":")
                  $SSID = $line[1].Trim()                 # removes white extra spaces
             }

             Elseif ($line -match "Network type")          #filters Network type
             {

                  $line = $line.split(":")
                  $network = $line[1].Trim()     
             }

             Elseif ($line -match "Authentication")          #filters Authentication
             {

                  $line = $line.split(":")
                  $Authen = $line[1].Trim()     
             }

             Elseif ($line -match "Encryption")
             {

                  $line = $line.split(":")
                  $Encryp = $line[1].Trim()     
             }

            Elseif ($line -match "BSSID")           #filters BSSID 
            {

                  $line = $line.split()[-1]
                  $BSSID = $line.Trim()     
                  $a = Get-Date          
                  $date = $a.ToShortDateString()       #  current date
                  $time = $a.ToShortTimeString()       #  current time
                  $SourceIP = ((ipconfig | findstr [0-9].\.)[0]).Split()[-1]     #Host IP 
                  $SourceName = $env:COMPUTERNAME        #Hostname
             }

          }
}