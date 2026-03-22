#!/bin/bash

# Retrieve metadata from Salesforce org
# Usage: ./scripts/retrieve-apex-class.sh [--specific] [--username <username>]

RETRIEVE_SPECIFIC=${1:-}
ORG_USERNAME=${3:-}

if [ "$RETRIEVE_SPECIFIC" = "--specific" ]; then
    echo "Retrieving specific Report-to-SOQL components from default org..."
    
    METADATA=(
        "ApexClass:ReportToSOQLConverter"
        "ApexClass:ReportToSOQLConverterTest"
        "ApexClass:ReportToSOQLController"
        "ApexPage:ReportToSOQLPage"
    )
    
    if [ -n "$ORG_USERNAME" ]; then
        echo "Target org: $ORG_USERNAME"
        sf project retrieve start --metadata "${METADATA[@]}" --target-org "$ORG_USERNAME"
    else
        sf project retrieve start --metadata "${METADATA[@]}"
    fi
    
    if [ $? -eq 0 ]; then
        echo "✓ Successfully retrieved Report-to-SOQL components"
    else
        echo "✗ Failed to retrieve Report-to-SOQL components"
        exit 1
    fi
else
    # Generic retrieve for any class
    if [ -z "$1" ]; then
        echo "Usage: $0 [--specific] [--username <username>]"
        echo "       $0 <ClassName> [--username <username>]"
        echo ""
        echo "Examples:"
        echo "  $0 --specific                    # Retrieve Report-to-SOQL components"
        echo "  $0 --specific --username myorg   # From specific org"
        echo "  $0 MyApexClass                   # Retrieve single class"
        echo "  $0 MyApexClass --username myorg  # From specific org"
        exit 1
    fi
    
    CLASS_NAME="$1"
    ORG_USERNAME="${3:-}"
    
    if [ -n "$ORG_USERNAME" ]; then
        echo "Retrieving ApexClass: $CLASS_NAME from org: $ORG_USERNAME..."
        sf project retrieve start --metadata "ApexClass:$CLASS_NAME" --target-org "$ORG_USERNAME"
    else
        echo "Retrieving ApexClass: $CLASS_NAME from default org..."
        sf project retrieve start --metadata "ApexClass:$CLASS_NAME"
    fi
    
    if [ $? -eq 0 ]; then
        echo "✓ Successfully retrieved $CLASS_NAME"
    else
        echo "✗ Failed to retrieve $CLASS_NAME"
        exit 1
    fi
fi
