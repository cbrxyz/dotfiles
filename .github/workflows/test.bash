FIRST_STRING="186.130"
SECOND_STRING="186.131"
if [[ "$FIRST_STRING" < "$SECOND_STRING" ]]; then
    echo "$FIRST_STRING is less than $SECOND_STRING"
else
    echo "$FIRST_STRING is not less than $SECOND_STRING"
fi
