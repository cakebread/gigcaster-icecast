#!/bin/bash

for i in {1..100}; do curl "http://localhost:8000/live.mp3" -O /dev/null & done

