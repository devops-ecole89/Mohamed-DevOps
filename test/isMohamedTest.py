import pytest
from isMohamed import is_mohamed

def test_is_mohamed():
    assert is_mohamed('Mohamed') == True
    assert is_mohamed('Pierre') == False
