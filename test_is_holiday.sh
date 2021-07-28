#!/usr/bin/env bash

. is_holiday.sh

# エラー発生時にスクリプトを終了しない
set +e

tests=0
success=0
failures=0

# 引数なし
tests=`expr $tests + 1`
echo "Tests:${tests}"
result=`is_holiday`
if [[ !$result ]] ; then
    echo 'SUCCESS'
    success=`expr $success + 1`
else
    echo 'FAILURE'
    failures=`expr $failures + 1`
fi

# 引数が空
tests=`expr $tests + 1`
echo "Tests:${tests}"
result=`is_holiday ""`
if [[ !$result ]] ; then
    echo 'SUCCESS'
    success=`expr $success + 1`
else
    echo 'FAILURE'
    failures=`expr $failures + 1`
fi

# 引数が日付の形式ではない
tests=`expr $tests + 1`
echo "Tests:${tests}"
result=`is_holiday 1234567`
if [[ !$result ]] ; then
    echo 'SUCCESS'
    success=`expr $success + 1`
else
    echo 'FAILURE'
    failures=`expr $failures + 1`
fi

# 引数が日付の形式ではない
tests=`expr $tests + 1`
echo "Tests:${tests}"
result=`is_holiday 12345678`
if [[ !$result ]] ; then
    echo 'SUCCESS'
    success=`expr $success + 1`
else
    echo 'FAILURE'
    failures=`expr $failures + 1`
fi

# 祝日に該当する（ハイフン区切り）
tests=`expr $tests + 1`
echo "Tests:${tests}"
result=`is_holiday 2021-1-1`
if [[ $result ]] ; then
    echo 'SUCCESS'
    success=`expr $success + 1`
else
    echo 'FAILURE'
    failures=`expr $failures + 1`
fi

# 祝日に該当する（スラッシュ区切り）
tests=`expr $tests + 1`
echo "Tests:${tests}"
result=`is_holiday 2021/1/1`
if [[ $result ]] ; then
    echo 'SUCCESS'
    success=`expr $success + 1`
else
    echo 'FAILURE'
    failures=`expr $failures + 1`
fi

# 祝日に該当する（月が前ゼロ）
tests=`expr $tests + 1`
echo "Tests:${tests}"
result=`is_holiday 2021/01/1`
if [[ $result ]] ; then
    echo 'SUCCESS'
    success=`expr $success + 1`
else
    echo 'FAILURE'
    failures=`expr $failures + 1`
fi

# 祝日に該当する（日が前ゼロ）
tests=`expr $tests + 1`
echo "Tests:${tests}"
result=`is_holiday 2021/1/01`
if [[ $result ]] ; then
    echo 'SUCCESS'
    success=`expr $success + 1`
else
    echo 'FAILURE'
    failures=`expr $failures + 1`
fi

# 祝日に該当する（月が前ゼロ、日が前ゼロ）
tests=`expr $tests + 1`
echo "Tests:${tests}"
result=`is_holiday 2021/01/01`
if [[ $result ]] ; then
    echo 'SUCCESS'
    success=`expr $success + 1`
else
    echo 'FAILURE'
    failures=`expr $failures + 1`
fi

# 祝日に該当しない（うるう年、祝日ではない）
tests=`expr $tests + 1`
echo "Tests:${tests}"
result=`is_holiday 2020/2/29`
if [[ !$result ]] ; then
    echo 'SUCCESS'
    success=`expr $success + 1`
else
    echo 'FAILURE'
    failures=`expr $failures + 1`
fi

# 引数が不正な日付（存在しない日付）
tests=`expr $tests + 1`
echo "Tests:${tests}"
result=`is_holiday 2021/2/29`
if [[ !$result ]] ; then
    echo 'SUCCESS'
    success=`expr $success + 1`
else
    echo 'FAILURE'
    failures=`expr $failures + 1`
fi

# 祝日に該当しない（存在する日付、祝日ではない）
tests=`expr $tests + 1`
echo "Tests:${tests}"
result=`is_holiday 2021/6/30`
if [[ !$result ]] ; then
    echo 'SUCCESS'
    success=`expr $success + 1`
else
    echo 'FAILURE'
    failures=`expr $failures + 1`
fi

# 引数が不正な日付（存在しない日付）
tests=`expr $tests + 1`
echo "Tests:${tests}"
result=`is_holiday 2021/6/31`
if [[ !$result ]] ; then
    echo 'SUCCESS'
    success=`expr $success + 1`
else
    echo 'FAILURE'
    failures=`expr $failures + 1`
fi

# 祝日に該当する
tests=`expr $tests + 1`
echo "Tests:${tests}"
result=`is_holiday 2021/7/22`
if [[ $result ]] ; then
    echo 'SUCCESS'
    success=`expr $success + 1`
else
    echo 'FAILURE'
    failures=`expr $failures + 1`
fi

# 引数が不正な日付
tests=`expr $tests + 1`
echo "Tests:${tests}"
result=`is_holiday 2021/99/99`
if [[ !$result ]] ; then
    echo 'SUCCESS'
    success=`expr $success + 1`
else
    echo 'FAILURE'
    failures=`expr $failures + 1`
fi

# 引数が日付の形式ではない
tests=`expr $tests + 1`
echo "Tests:${tests}"
result=`is_holiday 2021/725`
if [[ !$result ]] ; then
    echo 'SUCCESS'
    success=`expr $success + 1`
else
    echo 'FAILURE'
    failures=`expr $failures + 1`
fi

# 引数が日付の形式ではない
tests=`expr $tests + 1`
echo "Tests:${tests}"
result=`is_holiday 20217/25`
if [[ !$result ]] ; then
    echo 'SUCCESS'
    success=`expr $success + 1`
else
    echo 'FAILURE'
    failures=`expr $failures + 1`
fi

echo "Tests: ${tests}, Success: ${success}, Failures: ${failures}."
