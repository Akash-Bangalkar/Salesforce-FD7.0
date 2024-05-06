<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>First_Field</fullName>
        <field>Rating</field>
        <literalValue>Cold</literalValue>
        <name>First Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Second_Field</fullName>
        <field>Type</field>
        <literalValue>Other</literalValue>
        <name>Second Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <outboundMessages>
        <fullName>SFDX_OBM</fullName>
        <apiVersion>60.0</apiVersion>
        <endpointUrl>https://www.google.com/</endpointUrl>
        <fields>Active__c</fields>
        <fields>Id</fields>
        <includeSessionId>false</includeSessionId>
        <integrationUser>s.oliveira@sfdc.com.sandbox</integrationUser>
        <name>SFDX OBM</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <rules>
        <fullName>Ac Workflow</fullName>
        <actions>
            <name>First_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Second_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>SFDX_OBM</name>
            <type>OutboundMessage</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Account.CleanStatus</field>
            <operation>equals</operation>
            <value>In Sync,Different</value>
        </criteriaItems>
        <failedMigrationToolVersion>248.18.2</failedMigrationToolVersion>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
