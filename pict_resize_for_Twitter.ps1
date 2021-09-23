#�t�@�C���p�X�擾
param(
    [parameter(ValueFromRemainingArguments = $true)]
    [String[]]
    $Path
)

#System.Windows.Forms�C���|�[�g
add-type -AssemblyName System.Windows.Forms

#�摜�t�@�C�������i����D&D�\�j
foreach($p in $Path)
{
    #TwitterUpload���E��5MB�����ɉ摜���k��
    $twitPicMaxSize = 5MB
    #�I���W�i���摜�T�C�Y
    $orgFileSize = (Get-ChildItem $p).Length
    #�I���W�i���摜�T�C�Y��5MB�����̏ꍇ
    if ($orgFileSize -lt $twitPicMaxSize) 
    {
       continue
    }
    
    #�I���W�i���摜�T�C�Y��5MB�ȏ�̏ꍇ
    #���k��
    #upload�ő�T�C�Y�𒴂��Ȃ����߂̈��S����ݒ�
    $safetyRatio = 1MB
    $compRate = $orgFileSize / ($twitPicMaxSize - $safetyRatio)
    
    #�y�C���g�N��
    mspaint $p
        
    #�N���ҋ@
    Start-Sleep -m 2000
    
    [System.Windows.Forms.SendKeys]::SendWait("^(w)")
    Start-Sleep -m 500
    [System.Windows.Forms.SendKeys]::SendWait("{TAB}")
    Start-Sleep -m 500
    [System.Windows.Forms.SendKeys]::SendWait([math]::Truncate(1 / $compRate * 100))
    [System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
    Start-Sleep -m 500
    
    #�ۑ����ĕ���
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
