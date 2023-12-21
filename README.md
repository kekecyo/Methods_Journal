# Methods_Journal

[Movement recognition via channel-activation-wise sEMG attention](https://www.sciencedirect.com/science/article/pii/S1046202323001093)

Jiaxuan Zhang, Yuki Matsuda, Manato Fujimoto, Hirohiko Suwa, Keiichi Yasumoto

Current feature extraction methods for sEMG signals have been seriously limited by their stochasticity, transiency, and non-stationarity.
Our objective is to combat the difficulties induced by the aforementioned downsides of sEMG and thereby extract representative features for various downstream movement recognition.
We hence propose a novel 3-axis view of sEMG features composed of temporal, spatial, and channel-wise summary. We leverage the state-of-the-art architecture Transformer to enforce efficient parallel search and to get rid of limitations imposed by previous work in gesture classification. The transformer model is designed on top of an attention-based module, which allows for the extraction of global contextual relevance among channels and the use of this relevance for sEMG recognition. 

---------------------------------------------------------------------------------------------------------------------


System overview             |  Key question
:-------------------------:|:-------------------------:
![alt text](https://github.com/kekecyo/Methods_Journal/assets/154519750/9987e529-d54d-4cbd-9c03-6defb924b75f)  | <img width="1500" alt="image" src="https://github.com/kekecyo/Methods_Journal/assets/154519750/9d3be752-d8fd-4a1d-bd06-d65afd589863">


18 features extracted from DTCWT used in this paper and their brief explanations.

<p align="center">
<img width="800" alt="image" src="https://github.com/kekecyo/Methods_Journal/assets/154519750/cafb4213-b45e-4f18-8c74-5304002df37f">
</p>




## Setup

The feature engineering is conducted on Matlab.
Our proposed deep learning model is conducted on Pytorch env.
You can install the required dependencies using pip.

```bash
pip install -r requirements.txt
```

If you're using other than CUDA 10.2, you may need to install PyTorch for the proper version of CUDA. See [instructions](https://pytorch.org/get-started/locally/) for more details.

## Feature Processing and Model Training

_Preprocessing.m_: signal filtering and sample segmentation.

_dualtree_wavelet folder_: dual-tree complex wavelet transform (DTCWT) for extraction of temporal-spatial feature.

_EMG-Feature-Extraction-Toolbox_: different feature extraction methods conducted on DTCWT.

_Model_EMG_Trans.ipynb_: our proposed channel-wise Transformer-based model


## Citation
If you find this code useful in your research, please consider citing:

    @ARTICLE{MethodsKakaya23,
  	author={Jiaxuan, Zhang and Yuki, Matsuda and Manato, Fujimoto and Hirohiko, Suwa and Keiichi, Yasumoto},
  	journal={Methods, Elsevier}, 
  	title={Movement recognition via channel-activation-wise sEMG attention}, 
  	year={2023},
  	volume={218},
  	pages={39-47}}




