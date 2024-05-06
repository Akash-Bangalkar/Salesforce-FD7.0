<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Field</fullName>
        <field>Type</field>
        <literalValue>Existing Customer - Upgrade</literalValue>
        <name>Update Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>User_Update</fullName>
        <field>TotalOpportunityQuantity</field>
        <name>User Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>GBCI_Update</fullName>
        <actions>
            <name>Update_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>User_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.NextStep</field>
            <operation>equals</operation>
            <value>Support</value>
        </criteriaItems>
        <failedMigrationToolVersion>248.18.2</failedMigrationToolVersion>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
