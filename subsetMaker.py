# Simple piece of code for splitting up a fastq file.

# The entered limit multiplied by 4 and subtracted by 1 forms
# the desired amount of lines, since fastq reads consists of four lines.

limit = input("Enter limit: ")
target = "C0A7AACXX_101851-02_TGACCA_L001_R2.fastq"

with open(target) as fIn:
    with open("%s_SUBSET.%s"%tuple(target.rsplit('.', 1)), 'w') as fOut:
        for i, line in enumerate(fIn):
            if limit * 4 - 1 == i:
                break
            fOut.write(line)
