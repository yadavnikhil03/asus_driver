$urls = @(
    "https://drive.google.com/file/d/1FkxTyJ_VeMONH__ngTQ8z97ydK8qCVgj/view?usp=sharing",
    "https://drive.google.com/file/d/1abn-DThHfm4lPov5cp1S9On2BXu39w_I/view?usp=sharing",
    "https://drive.google.com/file/d/12AxQuMC7lEOmYsdh5WRNjp04DfDkH9Qt/view?usp=sharing",
    "https://drive.google.com/file/d/1zm-IWGxzlOML0gkylNzuddTTiIY3-ucx/view?usp=sharing",
    "https://drive.google.com/file/d/1tVnV2tdbX_rRw8KLurRJmbxkRdcDi54A/view?usp=sharing",
    "https://drive.google.com/file/d/1CRSo6en1HjGrW0sIu_-c37pK9DlqHYf1/view?usp=sharing",
    "https://drive.google.com/file/d/1kKpAHz9qwCNHua2SYjWxZY5LuVRui7dk/view?usp=sharing",
    "https://drive.google.com/file/d/1YEqnNq2oadTnJKvmXdu7yyugT4V92Utq/view?usp=sharing",
    "https://drive.google.com/file/d/1uNBePNFO7a79t8PRWlGwvbKtQwE1PhPt/view?usp=sharing",
    "https://drive.google.com/file/d/1IHT4cODZvoeUkBtnMZdf_IHX4btKqueN/view?usp=sharing",
    "https://drive.google.com/file/d/1CYlzDLUUeWim9JsxLgRL9A33Sbp9Z_wW/view?usp=sharing",
    "https://drive.google.com/file/d/1mYqhZrTGUVWvNoLrs-pwdGYpui8l80Do/view?usp=sharing",
    "https://drive.google.com/file/d/1G60LzflTXzg6GmYmJ3joK96KO3nnG2TK/view?usp=sharing",
    "https://drive.google.com/file/d/1bqkqnZ8L2ys0bT_CbFgkBu60r-geciP4/view?usp=sharing"
)

$jsonPath = "C:\Users\nikhi\Downloads\drivers\drivers.json"
$drivers = Get-Content $jsonPath -Raw | ConvertFrom-Json

# Enable modern TLS
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

foreach ($url in $urls) {
    if ($url -match '/d/([a-zA-Z0-9_-]+)') {
        $id = $Matches[1]
        Write-Host "Resolving ID: $id..."
        try {
            $ucUrl = "https://docs.google.com/uc?export=download&id=$id"
            $req = [System.Net.HttpWebRequest]::Create($ucUrl)
            $req.Method = "GET"
            $req.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
            
            $res = $req.GetResponse()
            $contentType = $res.ContentType
            $disp = $res.Headers["Content-Disposition"]
            
            $filename = $null
            
            # Case 1: Google Drive Warning page (HTML)
            if ($contentType -like "*text/html*") {
                $reader = New-Object System.IO.StreamReader($res.GetResponseStream())
                $html = $reader.ReadToEnd()
                $res.Close()
                
                # Extract filename using regex from warning page HTML
                if ($html -match 'class="uc-name-size"><a href="/open\?id=[a-zA-Z0-9_-]+">([^<]+)</a>') {
                    $filename = $Matches[1]
                }
            } else {
                # Case 2: Direct file download stream
                $res.Close()
                if ($disp -match 'filename="([^"]+)"') {
                    $filename = $Matches[1]
                }
            }
            
            if ($filename) {
                Write-Host "Matched ID $id -> $filename"
                
                # Find in JSON
                $matchedDriver = $drivers | Where-Object { $_.FileName -eq $filename }
                if ($matchedDriver) {
                    $matchedDriver.DownloadUrl = $url
                    Write-Host "Updated URL for $filename"
                } else {
                    Write-Host "Warning: Filename $filename not found in drivers.json"
                }
            } else {
                Write-Host "Failed to parse filename for ID $id"
            }
        }
        catch {
            Write-Host "Failed to query ID $id : $($_.Exception.Message)"
        }
    }
}

# Save updated drivers.json
$drivers | ConvertTo-Json -Depth 10 | Set-Content $jsonPath
Write-Host "drivers.json updated successfully!"
