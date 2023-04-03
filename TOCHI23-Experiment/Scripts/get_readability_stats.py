import spacy
from spacy_readability import Readability
import pandas as pd
import warnings
warnings.filterwarnings('ignore')
pd.set_option('display.max_colwidth', -1)
pd.set_option('display.float_format', lambda x: '%.3f' % x)
pd.set_option('display.max_rows', 500)
pd.set_option('display.max_columns', 500)
pd.set_option('display.width', 1000)

__author__ = 'HK Dambanemuya'
__version__ = 'Python 3'

# Import data
projects = pd.read_csv('../Data/projects.csv')

# Initialize NLP pipeline
nlp = spacy.load('en_core_web_sm')
read = Readability()
nlp.add_pipe(read, last=True)

# Convert customized project descriptions to docs
docs = [nlp(desc) for desc in projects['Customized Description']]

# Get Flesch-Kincaid grade level 
flesch_kincaid_grade_level = [doc._.flesch_kincaid_grade_level for doc in docs]
projects['Grade Level'] = flesch_kincaid_grade_level

# Get Flesch-Kincaid reading ease
flesch_kincaid_reading_ease = [doc._.flesch_kincaid_reading_ease for doc in docs]
projects['Reading Ease'] = flesch_kincaid_reading_ease

# Save data to csv
projects.to_csv('../Data/projects.csv', index=False)

# Display sample projects
print (projects.sample(5))