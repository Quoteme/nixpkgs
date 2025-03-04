{ lib
, buildPythonPackage
, fetchPypi
, pythonOlder
, glibcLocales
, typing-extensions
, unittestCheckHook
, isPy3k
}:

buildPythonPackage rec {
  pname = "PyPDF2";
  version = "2.10.7";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-PHkw2fK6JdybGC2cIpOtbeOtryo5NMfoxBeGVa6Mejk=";
  };

  LC_ALL = "en_US.UTF-8";
  buildInputs = [ glibcLocales ];

  propagatedBuildInputs = lib.optionals (pythonOlder "3.10") [
    typing-extensions
  ];

  # Tests broken on Python 3.x
  #doCheck = !(isPy3k);

  checkInputs = [ unittestCheckHook ];

  meta = with lib; {
    description = "A Pure-Python library built as a PDF toolkit";
    homepage = "http://mstamy2.github.com/PyPDF2/";
    license = licenses.bsd3;
    maintainers = with maintainers; [ desiderius vrthra ];
  };

}
