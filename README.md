# Methods_Journal

[Movement recognition via channel-activation-wise sEMG attention](https://www.sciencedirect.com/science/article/pii/S1046202323001093)

Jiaxuan Zhang, Yuki Matsuda, Manato Fujimoto, Hirohiko Suwa, Keiichi Yasumoto

Current feature extraction methods for sEMG signals have been seriously limited by their stochasticity, transiency, and non-stationarity.
Our objective is to combat the difficulties induced by the aforementioned downsides of sEMG and thereby extract representative features for various downstream movement recognition.
We hence propose a novel 3-axis view of sEMG features composed of temporal, spatial, and channel-wise summary. We leverage the state-of-the-art architecture Transformer to enforce efficient parallel search and to get rid of limitations imposed by previous work in gesture classification. The transformer model is designed on top of an attention-based module, which allows for the extraction of global contextual relevance among channels and the use of this relevance for sEMG recognition. 

---------------------------------------------------------------------------------------------------------------------


System overview             |  Time-frequency patching
:-------------------------:|:-------------------------:
![alt text](https://github.com/kekecyo/Methods_Journal/assets/154519750/9987e529-d54d-4cbd-9c03-6defb924b75f)  | <img width="1400" alt="image" src="https://github.com/kekecyo/Methods_Journal/assets/154519750/9d3be752-d8fd-4a1d-bd06-d65afd589863">


Fequencey-band-time-index visualization resutls [1],[2].

<p align="center">
<img width="900" alt="image" src="https://user-images.githubusercontent.com/34312998/133877630-9b2f2eec-11e0-4d41-8c36-5afd02dd78d6.png">
</p>




## Setup

You can install the required dependencies using pip.

```bash
pip install -r requirements.txt
```

If you're using other than CUDA 10.2, you may need to install PyTorch for the proper version of CUDA. See [instructions](https://pytorch.org/get-started/locally/) for more details.

## Training

```python
python main.py 
--epochs=xx
...
--dim=xx
--layers=xx
...
--dic_name <path/to/model_checkpoint> 
<model_checkpoint.pth>
```

You can set up different hyperparameters by --args.xx in _main.py_.

## Reference

[1] H. Chefer, S. Gur, and L. Wolf, “Generic attention-model explainability for interpreting bi-modal and encoder-decoder transformers,” CoRR, vol. abs/2103.15679, 2021. [Online]. Available: https://arxiv.org/abs/2103.15679

[2] Hila Chefer, Shir Gur, Lior Wolf, “Transformer interpretability beyond attention visualization,” arXiv preprint arXiv:2012.09838, 2020.

## Citation
If you find this code useful in your research, please consider citing:

    @ARTICLE{TNSREchen23,
  	author={Chen, Zheng and Yang, Ziwei and Zhu, Lingwei and Chen, Wei and Tamura, Toshiyo and Ono, Naoaki and Altaf-Ul-Amin, Md and Kanaya, Shigehiko and Huang, Ming},
  	journal={IEEE Transactions on Neural Systems and Rehabilitation Engineering}, 
  	title={Automated Sleep Staging via Parallel Frequency-Cut Attention}, 
  	year={2023},
  	volume={31},
  	pages={1974-1985}}




