#!/bin/bash

echo "Fix for Nordigen"
sudo sed -i $"s/'description'.*/\'description\'        => \'\' !== trim((string)(\$entry->getDescription() ?? \'\')) ? \$entry->getDescription() : \'(no description)\',/" /var/www/html/app/Services/Nordigen/Conversion/Routine/GenerateTransactions.php
