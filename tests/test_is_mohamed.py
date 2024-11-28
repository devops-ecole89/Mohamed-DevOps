from is_sudo import is_mohamed

def test_is_mohamed():
    assert is_mohamed('Mohamed') == True
    assert is_mohamed('Pierre') == False
    assert is_mohamed('Tom') == False
