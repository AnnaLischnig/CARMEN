
# CARMEN – Calcium Multiplexing Biosensor System

**Preprint:**  
Anna Lischnig, Yusuf Erdoğan, Benjamin Gottschalk, et al.  
*A Quad-Cistronic Fluorescent Biosensor System for Real-Time Detection of Subcellular Ca²⁺ Signals.*  
Authorea, March 03, 2025. DOI: [10.22541/au.174098553.38904074/v1](https://doi.org/10.22541/au.174098553.38904074/v1)

**Status:** Under revision  
**Addgene:** CARMEN will be available via Addgene pending publication.

---

This repository contains a Fiji macro and a set of Python scripts for processing and analysing four-channel calcium imaging data exported from Fiji (ImageJ).  
The workflow is designed for the **CARMEN calcium multiplexing approach**, including steps for:

- ROI-based signal extraction
- Background subtraction
- Data aggregation
- Optional curve fitting for fluorescence bleaching analysis

---

## 📁 Overview of Workflow Components

### 1. Fiji Macro
**`Fiji_Makro_CARMEN_MeasureFourChannelROI.ijm`**  
This ImageJ macro extracts mean grey values from manually selected ROIs across four imaging channels.  
It saves both the ROI set and one CSV per image and channel.

---

### 2. Python Scripts

#### **`CARMEN_combine_and_backgroundsubstract_CSVs.ipynb`**
- Combines and background-subtracts ROI intensity values.
- Assumes the *last ROI* in each image represents background.
- Merges four per-image CSVs (e.g. `Image01_Intensity FP1.csv` to `FP4.csv`) into one Excel file.
- Includes both raw and background-corrected data.

---

#### **`CARMEN_combine_and_backgroundsubstract_CSVs_endpoint.ipynb`**
Two-part script:

**Step 1:**  
Groups four per-channel CSV files (FB1 to FB4) per image and saves them as one Excel file.

**Step 2:**  
Combines data from multiple Excel files into a single table per channel, extracts the second data row,  
automatically determines background (last valid `MeanX`), and performs background subtraction (BS1–BS50).

---

#### **`CARMEN_combine_and_curvefitting_xlsmtemplate.ipynb`**  
(or: `CARMEN_combine_and_curvefitting_xlsxtemplate.ipynb`)

Includes use of either `CARMEN_template.xlsm` (macro-enabled) or `CARMEN_template.xlsx`.

**Step 1:**  
Groups four-channel CSVs by image and merges them into one Excel file per image.

**Step 2:**  
Inserts raw data into the Excel template and maps channels to specific sheets (BFP, GFP, RFP, NIR).  
Cleans up template sheets by removing trailing rows.

**Step 3:**  
Fits exponential decay curves to ROI bleaching traces using `scipy.optimize.curve_fit`.  
Background correction and optional outlier removal are included.

---

## 📥 Input Format

- `.csv` files from Fiji with filenames like:  
  `Image01_Intensity FP1.csv`, ..., `Image01_Intensity FP4.csv`
- Each file should include one ROI per row and have the **last ROI as background**.
- Templates for later steps:
  - `CARMEN_template.xlsm` or `CARMEN_template.xlsx` must be present in the specified folder.

---

## 📤 Output

- `.xlsx` files per image containing:
  - Sheets: FP1–FP4 (raw)
  - Sheets: FP1_bs–FP4_bs (background-subtracted)
- Combined `.xlsx` across multiple images, with:
  - Mean values (Mean1–Mean50)
  - Auto-selected background value
  - Background-subtracted values (BS1–BS50)
- Optional: Excel files with fitted bleach curves starting in column DF.

---

## 📦 Requirements


- Required libraries (can be installed via `pip install -r requirements.txt`):

```text
pandas
numpy
openpyxl
scipy
xlwings
```

---

## 📚 Citation
If you use this code, please cite the following preprint:
Anna Lischnig, Yusuf Erdoğan, Benjamin Gottschalk, et al.  
*A Quad-Cistronic Fluorescent Biosensor System for Real-Time Detection of Subcellular Ca²⁺ Signals.*  
Authorea, March 03, 2025. DOI: [10.22541/au.174098553.38904074/v1](https://doi.org/10.22541/au.174098553.38904074/v1)


