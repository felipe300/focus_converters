# FOCUS Converter

The FOCUS Converter is a command-line utility to convert billing data files from popular public cloud providers,
such as **Amazon Web Services**, **Microsoft Azure**, **Google Cloud** and **Oracle Cloud**, into the common
schema known as FOCUS. You can read the specification at [FinOps-Open-Cost-and-Usage-Spec/FOCUS_Spec].

The converter is optimized for:

- Ability to act on the large files and wire formats provided by cloud providers.
- Comprehensibility of the conversion process which encodes _an_ understanding of the specification as-written.
- Best-effort conversion where the appropriate data for FOCUS does not exist in the provider's data file.
- Modularity so that new types of billing data can be supported.

## Currently Supported Cloud Providers

- [Amazon Web Services]
- [Google Cloud]
- [Microsoft Azure]
- [Oracle Cloud]

Want to add your own? See [CONTRIBUTING.md]

## Conversion Rules

The conversion rules are defined in YAML files in the `conversion_configs` directory. Each file contains a list of
conversion rules, which are applied in order.

Rules are also exported per provider in the following directories based on format:

- **Markdown**: [Rules Export Markdown]
- **CSV**: [Rules Export CSV]

## Installation

The FOCUS converter supports Python 3.9 and above. If you meet these requirements, you can install with pip:

```sh
pip install focus_converter
```

After this, you will have a script called `focus-converter` in your path.

### Development Setup with Poetry

This project now uses Poetry for dependency management and environment reproducibility.

Poetry replaces the previous manual `venv + pip install` workflow with a cleaner and more reliable setup based on:

- `pyproject.toml`
- `poetry.lock`
- isolated virtual environments
- deterministic dependency resolution

This helps prevent dependency conflicts such as incompatible versions of `typer`, `click`, `pandera`, and `multimethod`.

**Prerequisites**

- Python 3.11+ (Python 3.11 is recommended for better compatibility)
- Poetry installed

Official Poetry documentation:

<https://python-poetry.org/>

**Install Poetry on Linux/macOS**:

```bash
curl -sSL https://install.python-poetry.org | python3 -
```

**Verify installation**:

```bash
poetry --version
```

**Clean Previous Virtual Environment (Optional)**

If you previously used `.venv` manually, remove it to avoid conflicts:

```bash
deactivate
rm -rf .venv
```

**Install Project Dependencies**

From the focus_converter_base directory:

```bash
cd focus_converter_base
poetry lock
poetry install
```

This will:

1. Resolve compatible dependencies
2. Generate poetry.lock
3. Create Poetry's managed virtual environment
4. Install all required packages

**Running the CLI**

Instead of using Python directly, run commands through Poetry:

```bash
poetry run python -m focus_converter.main --help
```

You should see the available commands:

- `convert`
- `convert-auto`
- `explain`
- `list-providers`

Example:

```bash
poetry run python -m focus_converter.main list-providers
```

**Recommended Dependency Pinning**

To improve reproducibility, critical dependencies were pinned to stable versions:

```toml
typer = "0.9.0"
click = "8.1.7"
focus-validator = "1.0.0"
multimethod = "1.9.1"
```

This avoids common compatibility issues introduced by newer package versions.

**Why Poetry?**

Poetry provides:

- reproducible environments
- safer dependency management
- lock file support (`poetry.lock`)
- better collaboration across teams
- easier CI/CD integration

This is especially important for FinOps and data tooling projects where dependency stability is critical.

## Example Usage

```bash
focus-converter convert --provider aws --data-path path/to/aws/parquet/cur/ --data-format parquet --parquet-data-format dataset --export-path /tmp/output/
```

Use `focus-converter list-providers` to see the other providers that are supported.

## Development setup

1. Clone this repository.
2. [Install Poetry] if you don't have it.
3. [Install libmagic] if you don't have it.
4. Run the following shell snippet:

```sh
cd focus_converter_base/
poetry install --only main --no-root
```

Before using `python -m focus_converter.main` as a substitute for the pre-installed `focus-converter` script and testing
repository changes, ensure to run the `poetry shell` command to set up the environment correctly.

## Provider Progress

Look at [pie charts] showing the progress of the conversion for each provider. For each provider there is a pie chart showing number of FOCUS dimensions added to the conversion plan vs pending.

## License

This project is licensed under the terms of the MIT license.

## Contributing

We're excited to work together. Please see [CONTRIBUTING.md] for information on how to get started.

[CONTRIBUTING.md]: CONTRIBUTING.md
[Install Poetry]: https://python-poetry.org/docs/#installation
[Install libmagic]: https://formulae.brew.sh/formula/libmagic
[FinOps-Open-Cost-and-Usage-Spec/FOCUS_Spec]: https://github.com/FinOps-Open-Cost-and-Usage-Spec/FOCUS_Spec
[Amazon Web Services]: https://github.com/finopsfoundation/focus_converters/tree/master/focus_converter_base/focus_converter/conversion_configs/aws
[Google Cloud]: https://github.com/finopsfoundation/focus_converters/tree/master/focus_converter_base/focus_converter/conversion_configs/gcp
[Microsoft Azure]: https://github.com/finopsfoundation/focus_converters/tree/master/focus_converter_base/focus_converter/conversion_configs/azure
[Oracle Cloud]: https://github.com/finopsfoundation/focus_converters/tree/master/focus_converter_base/focus_converter/conversion_configs/oci
[Rules Export Markdown]: https://github.com/finopsfoundation/focus_converters/tree/master/conversion_rules_export/markdown
[Rules Export CSV]: https://github.com/finopsfoundation/focus_converters/tree/master/conversion_rules_export/csv
[pie charts]: https://github.com/finopsfoundation/focus_converters/tree/master/progress/README.md
