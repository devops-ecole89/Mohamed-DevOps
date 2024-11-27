from isMohamed import is_mohamed

def test_is_mohamed():
    assert is_mohamed('Mohamed') == False
    assert is_mohamed('Pierre') == False
