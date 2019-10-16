{ buildGoPackage, fetchgit, stdenv }:

buildGoPackage rec {
  pname = "tea";
  version = "d1134e8008f7e6b24f3f233c97e9b6a67aadd1cd";
  src = fetchgit {
    url = "https://gitea.com/gitea/tea";
    rev = "d1134e8008f7e6b24f3f233c97e9b6a67aadd1cd";
    sha256 = "1l3vbvxlj8hhkdgp6h4r8gj4bgfvnmahd54jnkihvrmxr8kc6q1j";
  };
  goPackagePath = "code.gitea.io/tea";
  goDeps = ./deps.nix;
  meta = with stdenv.lib; {
    description = "A command line tool to interact with Gitea servers";
    homepage = "https://gitea.com/gitea/tea";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
