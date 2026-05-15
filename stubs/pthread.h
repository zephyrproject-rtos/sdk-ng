/*
 * Minimal pthread.h stub for bare-metal targets.
 *
 * Provides type definitions and function declarations needed by
 * GCC's gthr-posix.h when the toolchain is built with
 * --enable-threads=posix. No implementations are provided here;
 * the target OS (e.g. Zephyr with CONFIG_POSIX_API) supplies them.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 */

#ifndef _PTHREAD_H
#define _PTHREAD_H

#include <sys/types.h>
#include <sched.h>
#include <time.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef unsigned long pthread_t;
typedef unsigned int pthread_key_t;

typedef struct { int __data; } pthread_once_t;
typedef struct { int __data; } pthread_mutex_t;
typedef struct { int __data; } pthread_mutexattr_t;
typedef struct { int __data; } pthread_cond_t;
typedef struct { int __data; } pthread_condattr_t;
typedef struct { int __data; } pthread_rwlock_t;
typedef struct { int __data; } pthread_rwlockattr_t;
typedef struct { int __data; } pthread_attr_t;

#define PTHREAD_ONCE_INIT { 0 }
#define PTHREAD_MUTEX_INITIALIZER { 0 }
#define PTHREAD_COND_INITIALIZER { 0 }
#define PTHREAD_RWLOCK_INITIALIZER { 0 }
#define PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP { 0 }

#define PTHREAD_MUTEX_RECURSIVE 1

int pthread_once(pthread_once_t *, void (*)(void));

int pthread_key_create(pthread_key_t *, void (*)(void *));
int pthread_key_delete(pthread_key_t);
void *pthread_getspecific(pthread_key_t);
int pthread_setspecific(pthread_key_t, const void *);

int pthread_create(pthread_t *, const pthread_attr_t *,
                   void *(*)(void *), void *);
int pthread_join(pthread_t, void **);
int pthread_detach(pthread_t);
int pthread_cancel(pthread_t);
int pthread_equal(pthread_t, pthread_t);
pthread_t pthread_self(void);

int pthread_mutex_init(pthread_mutex_t *, const pthread_mutexattr_t *);
int pthread_mutex_destroy(pthread_mutex_t *);
int pthread_mutex_lock(pthread_mutex_t *);
int pthread_mutex_trylock(pthread_mutex_t *);
int pthread_mutex_timedlock(pthread_mutex_t *,
                            const struct timespec *);
int pthread_mutex_unlock(pthread_mutex_t *);

int pthread_mutexattr_init(pthread_mutexattr_t *);
int pthread_mutexattr_destroy(pthread_mutexattr_t *);
int pthread_mutexattr_settype(pthread_mutexattr_t *, int);

int pthread_cond_init(pthread_cond_t *, const pthread_condattr_t *);
int pthread_cond_destroy(pthread_cond_t *);
int pthread_cond_wait(pthread_cond_t *, pthread_mutex_t *);
int pthread_cond_timedwait(pthread_cond_t *, pthread_mutex_t *,
                           const struct timespec *);
int pthread_cond_signal(pthread_cond_t *);
int pthread_cond_broadcast(pthread_cond_t *);

int pthread_rwlock_rdlock(pthread_rwlock_t *);
int pthread_rwlock_tryrdlock(pthread_rwlock_t *);
int pthread_rwlock_wrlock(pthread_rwlock_t *);
int pthread_rwlock_trywrlock(pthread_rwlock_t *);
int pthread_rwlock_unlock(pthread_rwlock_t *);

int pthread_attr_init(pthread_attr_t *);
int pthread_attr_destroy(pthread_attr_t *);
int pthread_attr_setdetachstate(pthread_attr_t *, int);

int pthread_getschedparam(pthread_t, int *, struct sched_param *);
int pthread_setschedparam(pthread_t, int, const struct sched_param *);

int sched_yield(void);

#ifdef __cplusplus
}
#endif

#endif /* _PTHREAD_H */
