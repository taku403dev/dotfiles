. "${DOTPATH}/lib/util.sh"

# Summary: 標準入力から受けっとたファイル名を引数に指定したディレクトリ下に作成する。
# Example: 
#   $echo file1 file2 | . crate_file.sh dir1 dir2
#   ファイル、ディレクトリは複数指定可
# Args:
#   $1〜: ディレクトリを指定 (ディレクトリは複数指定可)
# Return:
#   成功: 0 失敗： 1

for file in $(cat -) 
do
  for dir in "$@"
  do
    [[ -d "$dir" ]] || mkdir "${dir}"
     touch "${dir}/${file}"
  done
done