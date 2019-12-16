# remote exploit, run commands locally
python gen_data.py | netcat challenge02.root-me.org 56032 | head -n 1