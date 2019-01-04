FROM continuumio/anaconda:2018.12
MAINTAINER heathmont

WORKDIR /root

RUN apt-get install -y git sudo unzip vim && \
    apt -y upgrade --force-yes -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" && \
    apt -y autoremove && \
    apt -y install --force-yes -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" qtdeclarative5-dev qml-module-qtquick-controls && \
    git clone https://github.com/fastai/fastai.git && \
    cd fastai && \
    echo 'export PATH=~/anaconda3/bin:$PATH' >> ~/.bashrc && \
    export PATH=~/anaconda3/bin:$PATH && \
    bash -c 'conda env update' && \
    echo 'source activate fastai' >> ~/.bashrc && \
    bash -c 'source activate fastai' && \
    cd .. && \
    jupyter notebook --generate-config && \
    echo "c.NotebookApp.ip = '0.0.0.0'" >> ~/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.open_browser = False" >> ~/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.token = ''" >> ~/.jupyter/jupyter_notebook_config.py && \
    bash -c 'pip install ipywidgets' && \
    bash -c 'jupyter nbextension enable --py widgetsnbextension --sys-prefix'

CMD jupyter notebook --allow-root
