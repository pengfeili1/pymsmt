"""
Note: This part of code is adapted from ParmEd with author as Jason Swails.
It is under GNU Lesser General Public License, version 2.1.
"""

MINICONDA=Miniconda-latest-Linux-x86_64.sh
MINICONDA_MD5=$(curl -s http://repo.continuum.io/miniconda/ | grep -A3 $MINICONDA | sed -n '4p' | sed -n 's/ *<td>\(.*\)<\/td> */\1/p')
wget http://repo.continuum.io/miniconda/$MINICONDA
if [[ $MINICONDA_MD5 != $(md5sum $MINICONDA | cut -d ' ' -f 1) ]]; then
    echo "Miniconda MD5 mismatch"
    exit 1
fi
bash $MINICONDA -b

export PATH=$HOME/miniconda/bin:$PATH
conda install --yes conda-build jinja2 binstar pip
conda config --add channels omnia

if [ -z "$MINIMAL_PACKAGES" ]; then
    conda create -y -n myenv python=$PYTHON_VERSION \
        numpy scipy netcdf4 pandas nose openmm-dev
    conda update -y -n myenv --all
else
    # Do not install the full numpy/scipy stack
    conda create -y -n myenv python=$PYTHON_VERSION nose numpy
fi

source activate myenv

export MSMTHOME=`pwd`
#export MSMTBINDIR=$MSMTHOME/bin
#export PATH=$MSMTHOME/bin:$PATH
export PYTHON=python

