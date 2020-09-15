#!/usr/bin/env bash

set -eux

# Sample custom configuration script - add your own commands here
# to add some additional commands for your environment
#
# For example:
# dnf install -y curl wget git tmux firefox xvfb

JDK_VERSION=${JDK_VERSION:-java-1.8.0-openjdk}

if [ "$INSTALL_OPENJDK" = "true" ] || [ "$INSTALL_OPENJDK" = "1" ]; then
	# Add vagrant user (if it doesn't already exist)
	sudo dnf install -y "${JDK_VERSION}.x86_64" "${JDK_VERSION}-devel.x86_64"
fi

GraalVM_RELEASE_VERSION=${GraalVM_RELEASE_VERSION:-vm-20.2.0/graalvm-ce-java8-linux-amd64-20.2.0}
GraalVM_RELEASE_URL="https://github.com/graalvm/graalvm-ce-builds/releases/download/${GraalVM_RELEASE_VERSION}.tar.gz"

wget -q ${GraalVM_RELEASE_URL}
wget ${GraalVM_RELEASE_URL} -qO - | sudo tar -xzvf - -C /opt

#Prepend the GraalVM bin directory to the PATH environment variable: $ export PATH=<path to GraalVM>/bin:$PATH 
#To verify whether you are using GraalVM, run: $ which java
echo 'export PATH=/opt/graalvm-ce-java8-20.2.0/bin:$PATH' >> ~/.bashrc

#Set the JAVA_HOME environment variable to resolve to the GraalVM installation directory:
echo 'export JAVA_HOME=/opt/graalvm-ce-java8-20.2.0' >> ~/.bashrc

#source ~/.bashrc
#java -version

#sudo /opt/graalvm-ce-java8-20.2.0/bin/gu install native-image
#sudo /opt/graalvm-ce-java8-20.2.0/bin/gu install llvm-toolchain


# To install the LLVM toolchain component, run:
#gu install llvm-toolchain


# To install GraalVM Native Image, run:
# gu install native-image
