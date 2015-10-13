for i in $(seq 1 5 2001);do
    if [[ $(expr ${i} % 7) -eq 0 ]]; then
        java -cp ABAGAIL.jar opt.test.AssignmentTwo ${i}
    else
        java -cp ABAGAIL.jar opt.test.AssignmentTwo ${i} &
    fi
done
