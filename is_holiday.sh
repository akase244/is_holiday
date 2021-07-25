#!/usr/bin/env bash

set -eu

function is_holiday() {
    # 引数なしの場合
    if [ $# -eq 0 ] ; then
       echo 'FALSE'
       exit 1
    fi

    # 引数が空の場合
    if [ "$1" = "" ] ; then
       echo 'FALSE'
       exit 1
    fi

    # 引数が日付の形式ではない場合
    if [[ ! "$1" =~ ^(19[0-9]{2}|20[0-9]{2})(/|-)(0?[1-9]|1[0-2])(/|-)(0?[1-9]|[12][0-9]|3[01])$ ]] ; then
       echo 'FALSE'
       exit 1
    fi

    # 引数を元にYYYYMMDD形式にフォーマット
    local TARGET_DATE=`date '+%Y%m%d' -d $1 2>/dev/null`
    # 引数が不正な日付（例: 2021/6/31）の場合
    if [ "$TARGET_DATE" = "" ] ; then
       echo 'FALSE'
       exit 1
    fi

    # 内閣府から祝日のCSVを取得（1行目はヘッダー行のためスキップ）
    local HOLIDAYS=`curl -sL https://www8.cao.go.jp/chosei/shukujitsu/syukujitsu.csv |iconv -f cp932 -t utf8 |tail -n +2`
    local HOLIDAY=""
    for HOLIDAY in $HOLIDAYS;
    do
       # 第1カラム（日付）を取得
       local HOLIDAY_DATE=`echo $HOLIDAY |cut -d , -f 1`
       # 祝日の日付を元にYYYYMMDD形式にフォーマット
       local FORMATTED_HOLIDAY_DATE=`date '+%Y%m%d' -d $HOLIDAY_DATE 2>/dev/null`
       # 祝日が不正な日付（例: 2021/6/31）の場合
       if [ "$FORMATTED_HOLIDAY_DATE" = "" ] ; then
          # 処理を止めずに繰り返す
          continue
       fi
       # 引数が祝日に該当した場合
       if [ $FORMATTED_HOLIDAY_DATE = $TARGET_DATE ] ; then
           echo 'TRUE'
           exit 0
       fi
    done
    # 引数が祝日に該当しなかった場合
    echo 'FALSE'
    exit 0
}
