#!/bin/bash


TO_ADDRESS=$1
SUBJECT=$2
ORDER_ID=$3
PROBE_COST=$4
CYBORG_COST=$5
SHIPPING_COST=$6
TAX_COST=$7
TOTAL_AMOUNT=$8

EMAIL_BODY=$(sed -e "s|ORDER_ID|$ORDER_ID|g" \
                  -e "s|PROBE_COST|$PROBE_COST|g" \
                  -e "s|CYBORG_COST|$CYBORG_COST|g" \
                   -e "s|SHIPPING_COST|$SHIPPING_COST|g" \
                   -e "s|TAX_COST|$TAX_COST|g" \
                  -e "s|TOTAL_AMOUNT|$TOTAL_AMOUNT|g" mail.html)


{
echo "To: $TO_ADDRESS"
echo "Subject: $SUBJECT"
echo "Content-Type: text/html"
echo ""
echo "$EMAIL_BODY"
} | msmtp "$TO_ADDRESS"