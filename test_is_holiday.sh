#!/usr/bin/env bash

. is_holiday.sh

# エラー発生時にスクリプトを終了しない
set +e

# 引数なし
RESULT=`is_holiday`
if [[ !$RESULT ]] ; then
    echo 'SUCCESS'
fi

# 引数が空
RESULT=`is_holiday ""`
if [[ !$RESULT ]] ; then
    echo 'SUCCESS'
fi

# 引数が日付の形式ではない
RESULT=`is_holiday 1234567`
if [[ !$RESULT ]] ; then
    echo 'SUCCESS'
fi

# 引数が日付の形式ではない
RESULT=`is_holiday 12345678`
if [[ !$RESULT ]] ; then
    echo 'SUCCESS'
fi

# 祝日に該当する（ハイフン区切り）
RESULT=`is_holiday 2021-1-1`
if [[ $RESULT ]] ; then
    echo 'SUCCESS'
fi

# 祝日に該当する（スラッシュ区切り）
RESULT=`is_holiday 2021/1/1`
if [[ $RESULT ]] ; then
    echo 'SUCCESS'
fi

# 祝日に該当する（月が前ゼロ）
RESULT=`is_holiday 2021/01/1`
if [[ $RESULT ]] ; then
    echo 'SUCCESS'
fi

# 祝日に該当する（日が前ゼロ）
RESULT=`is_holiday 2021/1/01`
if [[ $RESULT ]] ; then
    echo 'SUCCESS'
fi

# 祝日に該当する（月が前ゼロ、日が前ゼロ）
RESULT=`is_holiday 2021/01/01`
if [[ $RESULT ]] ; then
    echo 'SUCCESS'
fi

# 祝日に該当しない（うるう年、祝日ではない）
RESULT=`is_holiday 2020/2/29`
if [[ !$RESULT ]] ; then
    echo 'SUCCESS'
fi

# 引数が不正な日付（存在しない日付）
RESULT=`is_holiday 2021/2/29`
if [[ !$RESULT ]] ; then
    echo 'SUCCESS'
fi

# 祝日に該当しない（存在する日付、祝日ではない）
RESULT=`is_holiday 2021/6/30`
if [[ !$RESULT ]] ; then
    echo 'SUCCESS'
fi

# 引数が不正な日付（存在しない日付）
RESULT=`is_holiday 2021/6/31`
if [[ !$RESULT ]] ; then
    echo 'SUCCESS'
fi

# 祝日に該当する
RESULT=`is_holiday 2021/7/22`
if [[ $RESULT ]] ; then
    echo 'SUCCESS'
fi

# 引数が不正な日付
RESULT=`is_holiday 2021/99/99`
if [[ !$RESULT ]] ; then
    echo 'SUCCESS'
fi

# 引数が日付の形式ではない
RESULT=`is_holiday 2021/725`
if [[ !$RESULT ]] ; then
    echo 'SUCCESS'
fi

# 引数が日付の形式ではない
RESULT=`is_holiday 20217/25`
if [[ !$RESULT ]] ; then
    echo 'SUCCESS'
fi
