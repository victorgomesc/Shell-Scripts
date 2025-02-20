#!/bin/bash
# VICTOR GOMES DA COSTA - 511356

# Predefined Variables ============================================================================
STUDANT_NAME="VICTOR"
AMI_UBUNTU="ami-04b4f1a9cf54c11d0"

SG_LOG=sg.log
EC2_LOG=ec2.log

# AWS Configure pre configured ====================================================================
echo "This script already expects aws configure to be configured !"


# Create and Configure Security Group =============================================================

# Create log file empty
> $SG_LOG

# Create Security Group
echo "Creating Security Group ..."

aws ec2 create-security-group \
--group-name SecurityGroup_Lab12 \
--description "Security Group for lab12" >> $SG_LOG 

# Configure HTTP Rule
aws ec2 authorize-security-group-ingress \
--group-name SecurityGroup_Lab12 --to-port 80 \
--ip-protocol tcp --cidr-ip 0.0.0.0/0 --from-port 80 >> $SG_LOG

# Configure SSH Rule
aws ec2 authorize-security-group-ingress \
--group-name SecurityGroup_Lab12 --to-port 22 \
--ip-protocol tcp --cidr-ip 0.0.0.0/0 --from-port 22 >> $SG_LOG

# Configure HTTPS Rule
aws ec2 authorize-security-group-ingress \
--group-name SecurityGroup_Lab12 --to-port 443 \
--ip-protocol tcp --cidr-ip 0.0.0.0/0 --from-port 443 >> $SG_LOG

# Security Group ID
SECURITY_GROUP_ID=$(aws ec2 describe-security-groups --filters \
Name=group-name,Values="SecurityGroup_Lab12" --query "SecurityGroups[0].GroupId" --output text)

# Output of data
echo "Security Group was created with successfully"
echo "Security Group ID : $SECURITY_GROUP_ID" 


# Create Instance and obtain data =================================================================

# Create log file empty
> $EC2_LOG

# Create Instance with parameters
echo "Creating EC2 Instance ..."

aws ec2 run-instances \
--image-id $AMI_UBUNTU \
--instance-type t2.micro \
--key-name vockey \
--security-group-ids $SECURITY_GROUP_ID \
--user-data file://user_data.sh \
--tag-specifications 'ResourceType=instance,Tags=
[{Key=Name,Value=Lab12-'$STUDANT_NAME'}]' >> $EC2_LOG

# Instance ID
INSTANCE_ID=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=Lab12-$STUDANT_NAME" \
--query "Reservations[*].Instances[*].InstanceId" --output text)

# Instance IP
INSTANCE_IP=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=Lab12-$STUDANT_NAME" \
--query "Reservations[*].Instances[*].PublicIpAddress" --output text)

# Output of data
echo "EC2 Instance was created with successfully"
echo "EC2 ID : $INSTANCE_ID"
echo "EC2 IP : $INSTANCE_IP"


# Open in firefox =================================================================================

# Wait 3 minute to instance running
echo "Wait 3 minutes to initialize instance ..."
sleep 180

# Open application in web
firefox $IP_INSTANCE