[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls,[Net.SecurityProtocolType]::Tls11,[Net.SecurityProtocolType]::Tls12


#Establish connection with Vcenter 

#devqa = "fill the Vcenter IP"
#preprod = "fill the Vcenter IP"
#parago = "fill the Vcenter IP"
#corpSCL = Vcenter URL
#corpDFW = Vcenter URL

Import-Module VMware.VimAutomation.Core

#define the Vcenter 
$Vcenter='fill the Vcenter IP'

$mycred=get-Credentials
#define and fill a Service account here instead of giving credentials everytime

#connecting to vcenter
$vc=Connect-Viserver -server $vc -Credentials $mycred

#to Retrieve all the Alerts/Alarms in the Datacenter
$dc=Get-Datacenter

#lists all the Alarms with the Entity name
$dc.ExtensionData.TriggeredAlarmState | select @{Name='Entity'; Expression={Get-View -Id $.Entity | select -ExpandProperty name}},overallstatus,@{Name='Alarm';Expression={(Get-View -Id $.Alarm).info.name}}

#this is for Hosts and Clusters

$HostAlerts=Get-Vmhost | Get-View | Where-object {$_.OverallStatus -notlike "Green"}

if(!$HostAlerts)
{
    echo "All hosts/clusters are running fine"
}
else
{
    foreach($ab in $HostAlerts)
    {
        echo $ab+"has memory issue"
    }
}

$DatastoreAlerts=Get-Datastore | get-view | where-object {$_.OverallStatus -notlike "Green"} 

if(!$DatastoreAlerts)
{
    echo "All Datastores are running fine"
}
else
{
      foreach($abc in $DatastoreAlerts)
    {
        echo $abc+"has"+$DatastoreAlerts.FreespaceGb
    }
}




$mailbody=@" "




$GetDate=Get-Date
$mailbody=$mailbody.replace("getdate",$getdate)


Noreply-VCenterreports@bhn.com

Send-MailMessage -From 'no-replyPasswordExpiry@yournetwork.com' -To $to -Subject $EmailSubject3 -Body $Message3  -BodyAsHtml  -SmtpServer "ip" -Port "25"