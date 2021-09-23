#ファイルパス取得
param(
    [parameter(ValueFromRemainingArguments = $true)]
    [String[]]
    $Path
)

#System.Windows.Formsインポート
add-type -AssemblyName System.Windows.Forms

#画像ファイル処理（複数D&D可能）
foreach($p in $Path)
{
    #TwitterUpload限界の5MB未満に画像を縮小
    $twitPicMaxSize = 5MB
    #オリジナル画像サイズ
    $orgFileSize = (Get-ChildItem $p).Length
    #オリジナル画像サイズが5MB未満の場合
    if ($orgFileSize -lt $twitPicMaxSize) 
    {
       continue
    }
    
    #オリジナル画像サイズが5MB以上の場合
    #圧縮率
    #upload最大サイズを超えないための安全率を設定
    $safetyRatio = 1MB
    $compRate = $orgFileSize / ($twitPicMaxSize - $safetyRatio)
    
    #ペイント起動
    mspaint $p
        
    #起動待機
    Start-Sleep -m 2000
    
    [System.Windows.Forms.SendKeys]::SendWait("^(w)")
    Start-Sleep -m 500
    [System.Windows.Forms.SendKeys]::SendWait("{TAB}")
    Start-Sleep -m 500
    [System.Windows.Forms.SendKeys]::SendWait([math]::Truncate(1 / $compRate * 100))
    [System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
    Start-Sleep -m 500
    
    #保存して閉じる
    [System.Windows.Forms.SendKeys]::SendWait("^(s)")
    $originalFilePath = (Get-item $p).DirectoryName
    $originalFileName = (Get-ChildItem $p).BaseName
    $originalFileExtension = (Get-ChildItem $p).Extension
    $resizeFileNameFix = "_resize"
    $resizeFileName = $originalFilePath + "\" + $originalFileName + $resizeFileNameFix + $originalFileExtension
    [System.Windows.Forms.SendKeys]::SendWait("%{F12}")
    [System.Windows.Forms.SendKeys]::SendWait($resizeFileName)
    [System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
    [System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
    [System.Windows.Forms.SendKeys]::SendWait("%")
    [System.Windows.Forms.SendKeys]::SendWait("F")
    [System.Windows.Forms.SendKeys]::SendWait("X")
    
    sleep -s 10
}
