FROM python:3.6

RUN apt-get update && apt-get install -y git wget build-essential vim unzip git

WORKDIR /workdir

ADD MCR_R2018a_glnxa64_installer.zip /workdir/

ADD install_matlab_runtime.sh /workdir/
RUN /bin/bash install_matlab_runtime.sh

ADD requirements.txt /workdir/
RUN pip install -r /workdir/requirements.txt

ENV DYLD_LIBRARY_PATH="/usr/local/MATLAB/MATLAB_Runtime/v94/runtime/glnxa64:/usr/local/MATLAB/MATLAB_Runtime/v94/bin/glnxa64:/usr/local/MATLAB/MATLAB_Runtime/v94/sys/os/glnxa64:/usr/local/MATLAB/MATLAB_Runtime/v94/extern/bin/glnxa64"
ENV LD_LIBRARY_PATH="${DYLD_LIBRARY_PATH}:${LD_LIBRARY_PATH}"

ENV PYTHONPATH="/workdir/gmdh_matlab/python_packages/gmdh/for_redistribution_files_only/:${PYTHONPATH}"
#RUN python /workdir/gmdh_matlab/python_packages/gmdh/for_redistribution_files_only/setup.py install
CMD python setup.py install

CMD jupyter notebook --allow-root --no-browser --ip=0.0.0.0
