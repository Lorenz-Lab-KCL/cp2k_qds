#

convergence() {
    isInFile=$(cat $1 | grep -c 'GEOMETRY OPTIMIZATION COMPLETED')

    if [ $isInFile -eq 0 ]; then
	echo "NOT_CONVERGED" > NOT_CONVERGED.tmp
    else
	echo "CONVERGED"
    fi
}

new_coord() {
    head -n 1 $1 > n_atoms.tmp
    num_atoms=$(cat n_atoms.tmp)
    echo "$num_atoms+2" | bc > num_lines.tmp

    num_lines=$(cat num_lines.tmp)
    tail -n $num_lines *-pos*.xyz > last.xyz

    rm -r n_atoms.tmp num_lines.tmp

    mv mol.xyz ini.xyz
    mv last.xyz mol.xyz
}

for i in InP_*; do
    cd $i
    convergence output.out
    cd ..
done

# Finding out the success rate

total=$(ls -ld */ | wc -l)
not_succ=$(find . -name "NOT_CONVERGED.tmp" | wc -l)
succ=$(echo "$total-$not_succ"| bc -l)
succ_rate=$(echo "($succ/$total)*100" | bc -l)
echo Succesful cases: $succ
echo Success rate: $succ_rate %

# Second attempt to re-relax the molecule with the last computed geometry 

find . -name "NOT_CONVERGED.tmp" -printf "%h\n" > normal_settings.tmp

for i in $(cat normal_settings.tmp); do
    cd $i
    new_coord mol.xyz  
    cd ..
done
