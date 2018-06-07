#!/bin/bash

kill $(ps aux | grep 'simulator*' | awk '{print $2}')