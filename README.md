# SD

An __Ansible__ playbook for creating Stable Diffusion artworks with [giger](https://github.com/artificialhoney/giger). It uses best practices, such as embedding the **add_detail** LoRA and textual inversion with **EasyNegative** and **BadHands**.

## Installation

```bash
git clone https://github.com/artificialhoney/sd.git
pip install giger ansible git+https://github.com/ai-forever/Real-ESRGAN.git
```

## Usage

**Create images from prompt**

```bash
ansible-playbook playbook.yml -e config="examples/palina.yml" -e project="mermaid" --tags txt2img
```

**Swap face in generated images**

```bash
ansible-playbook playbook.yml -e config="examples/palina.yml" -e project="mermaid" --tags swap
```

**Upscale images**

```bash
ansible-playbook playbook.yml -e config="examples/palina.yml" -e project="mermaid" --tags upscale
```

See [examples/palina.yml](examples/palina.yml) for valid projects configuration.

<a target="_blank" href="https://colab.research.google.com/github/artificialhoney/sd/blob/main/examples/palina.ipynb">
  <img src="https://colab.research.google.com/assets/colab-badge.svg" alt="Open In Colab"/>
</a>

## License

Licensed under the [MIT License](LICENSE.txt) (MIT).

## Appendix

### Models

- [stablediffusionapi/majicmix-v7](https://huggingface.co/stablediffusionapi/majicmix-v7) - Realistic
- [Lykon/DreamShaper](https://huggingface.co/Lykon/DreamShaper) - Realistic, Fantasy
- [stablediffusionapi/counterfeit-v30](https://huggingface.co/stablediffusionapi/counterfeit-v30) - Manga, Sexy
- [stablediffusionapi/realistic-vision-v51](https://huggingface.co/stablediffusionapi/realistic-vision-v51) - Realistic, Sexy
- [Meina/MeinaMix_V11](https://huggingface.co/Meina/MeinaMix_V11) - Manga, Sexy
- [stablediffusionapi/rev-animated](https://huggingface.co/stablediffusionapi/rev-animated) - Manga, Sexy
- [stablediffusionapi/cetusmix](https://huggingface.co/stablediffusionapi/cetusmix) - Manga, Sexy
- [stablediffusionapi/urpm-v13](https://huggingface.co/stablediffusionapi/urpm-v13) - Realistic, Sexy
