#Script to delete backup files
$bacs = Get-ChildItem $location # use "-Filter *.bak" or "-Filter *.trn" for deleting bak or trn files specifically
$container="Container Name"
$StorageAccountName="Storage Account Name"
$StorageAccountKey="Storage Account Key"
$context = New-AzureStorageContext -StorageAccountName $StorageAccountName -StorageAccountKey $StorageAccountKey
$filelist = Get-AzureStorageBlob -Container $container -Context $context
foreach ($file in $filelist | Where-Object {$_.LastModified.DateTime -lt ((Get-Date).AddDays(-5))})
{
$removefile = $file.Name
if ($removefile -ne $null)
{
Write-Host "Removing file $removefile"
Remove-AzureStorageBlob -Blob $removeFile -Container $container -Context $context
}
}