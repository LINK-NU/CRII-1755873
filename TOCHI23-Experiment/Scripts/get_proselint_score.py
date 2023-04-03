import proselint
from proselint import score
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

# List of customized project descriptions
descriptions = list(projects['Customized Description'])

lints = []
scores = []

# Iterate through customized project descriptions
for idx, description in enumerate(descriptions):
    
    # Call proselint function
    suggestions = proselint.tools.lint(description)

    # Strip suggestion text from full description
    out = [suggestion[:2] for suggestion in suggestions]

    # Print customized project name
    print (projects['Customized Name'][idx])

    # Add suggestions to lints list
    lints.append(out)
    print(out)
    # Add proselint score to scores list
    scores.append(len(suggestions))
    print('\n')

# Add proselint suggestions and scores to data
projects['Proselint Suggestions'] = lints
projects['Proselint Score'] = scores

# Save updated dataframe to csv
projects.to_csv('../Data/projects.csv', encoding='utf8', index=False)
