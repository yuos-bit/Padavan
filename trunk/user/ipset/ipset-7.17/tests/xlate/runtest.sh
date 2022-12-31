#!/bin/bash

DIFF=$(which diff)
if [ ! -x "$DIFF" ] ; then
	echo "ERROR: missing diff"
	exit 1
fi

IPSET_XLATE=$(which ipset-translate)
if [ ! -x "$IPSET_XLATE" ] ; then
	echo "ERROR: ipset-translate is not installed yet"
	exit 1
fi

TMP=$(mktemp)
ipset-translate restore < xlate.t &> $TMP
if [ $? -ne 0 ]
then
	cat $TMP
	echo -e "[\033[0;31mERROR\033[0m] failed to run ipset-translate"
	exit 1
fi
${DIFF} -u xlate.t.nft $TMP
if [ $? -eq 0 ]
then
	echo -e "[\033[0;32mOK\033[0m] tests are fine!"
else
	echo -e "[\033[0;31mERROR\033[0m] unexpected ipset to nftables translation"
fi
