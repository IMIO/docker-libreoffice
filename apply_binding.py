#!/usr/bin/env python3

import csv

APPLY_FONT_SUBSTITUTION = """
<item oor:path="/org.openoffice.Office.Common/Font/Substitution">
    <prop oor:name="Replacement" oor:op="fuse">
        <value>true</value>
    </prop>
</item>
"""

FONT_SUBSTITUTION_PAIR_ITEM = """\n
<item oor:path="/org.openoffice.Office.Common/Font/Substitution/FontPairs">  <node oor:name="_{index}" oor:op="replace">
    <prop oor:name="Always" oor:op="fuse">
       <value>true</value>
    </prop>
    <prop oor:name="ReplaceFont" oor:op="fuse">
      <value>{origin}</value>
    </prop>
    <prop oor:name="OnScreenOnly" oor:op="fuse">
      <value>false</value>
    </prop>
    <prop oor:name="SubstituteFont" oor:op="fuse">
      <value>{substitute}</value>
    </prop>
  </node>
</item>
"""

config = APPLY_FONT_SUBSTITUTION + '\n'

with open('font-mappings.csv') as csv_file:
    mappings = csv.reader(csv_file)
    for i, mapping in enumerate(mappings):
        config += FONT_SUBSTITUTION_PAIR_ITEM.format(index=i, origin=mapping[0], substitute=mapping[1])

with open('/home/imio/.config/libreoffice/4/user/registrymodifications.xcu', 'r') as cfg_file:
    content = cfg_file.read()

content = content.replace('</oor:items>', config + '\n</oor:items>')

with open('/home/imio/.config/libreoffice/4/user/registrymodifications.xcu', 'w') as cfg_file:
    cfg_file.write(content)
