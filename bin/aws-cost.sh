#!/usr/bin/env bash

# Get this month's AWS billing cost.

aws --profile michael ce get-cost-and-usage \
    --time-period "Start=$(date -v1d -v$(date +%m)m -v$(date +%Y)y +%Y-%m-%d),End=$(date -v1d -v+1m -v-1d -v$(date +%m)m -v$(date +%Y)y +%Y-%m-%d)" \
    --granularity MONTHLY \
    --metrics "UnblendedCost"
