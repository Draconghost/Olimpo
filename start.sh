#!/bin/bash

echo "========================================"
echo "  GameStudios Engine - Starting..."
echo "========================================"
echo ""

# Check if node_modules exists
if [ ! -d "node_modules" ]; then
    echo "Installing dependencies..."
    npm install
    echo ""
fi

echo "Starting GameStudios Engine..."
echo ""
npm start
