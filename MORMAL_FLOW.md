# Normal Flow to check Installation

1. **Validate CLI**

```bash
poetry run python -m focus_converter.main --help
```

2. **List supported providers**

```bash
poetry run python -m focus_converter.main list-providers
```

3. **Inspect conversion parameters**

```bash
poetry run python -m focus_converter.main convert --help

# AND
poetry run python -m focus_converter.main convert-auto --help
```

4. **Use included sample data**

Check the sample data in the folder:

```bash
focus_converter/exported_sample_data/aws_cur.csv
```

5. **Run a real conversion**

```bash
cd focus_converter_base/

poetry run python -m focus_converter.main convert \
  --provider aws-cur \
  --data-path focus_converter/exported_sample_data/aws_cur.csv \
  --data-format csv \
  --export-path output.csv
```
